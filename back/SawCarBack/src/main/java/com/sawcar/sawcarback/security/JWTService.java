package com.sawcar.sawcarback.security;

import com.sawcar.sawcarback.user.User;
import com.sawcar.sawcarback.user.UserRepository;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.data.domain.Example;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.Date;
import java.util.Map;
import java.util.function.Function;

@Service
public class JWTService {
    private final TokenRepository tokenRepository;
    private final UserRepository userRepository;
    private static final String SECRET_KEY="14343209b99d1c4a7a23ba01cd1944b5b775b6fc491664ac722612d08b54bdbb";

    public JWTService(TokenRepository tokenRepository, UserRepository userRepository) {
        this.tokenRepository = tokenRepository;
        this.userRepository = userRepository;
    }

    public String extractUsername(String token){
        return extractClaim(token,Claims::getSubject);
    }

    public <T>T extractClaim(String token, Function<Claims,T> claimsResolver){
        final Claims claims=extractAllClaims(token);
        return  claimsResolver.apply(claims);
    }
    private Claims extractAllClaims(String token){
        return Jwts
                .parserBuilder()
                .setSigningKey(getSignKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    public boolean isTokenValid(String token, UserDetails userDetails){

        final String username = extractUsername(token);
        return (username.equals(userDetails.getUsername())&&!isTokenExpired(token)&&tokenRepository.isValid(token));
    }

    private boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    private Date extractExpiration(String token) {
        return extractClaim(token,Claims::getExpiration);
    }

    private Key getSignKey() {
        byte[] keyBytes= Decoders.BASE64.decode(SECRET_KEY);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    public String generateToken(
            Map<String, Object> extraClaims,
            UserDetails userDetails){
        return Jwts.builder()
                .setClaims(extraClaims)
                .setSubject(userDetails.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis()+1000*60*24))
                .signWith(getSignKey(), SignatureAlgorithm.HS256)
                .compact();
    }
    public String generateToken(
            UserDetails userDetails){
        var jwt= Jwts.builder()
                .setSubject(userDetails.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis()+1000*60*24))
                .signWith(getSignKey(), SignatureAlgorithm.HS256)
                .compact();
        this.deactivateTokens(userDetails.getUsername());
        Token token=new Token(userRepository.getUserId(userDetails.getUsername()),jwt,new Date(),true);
        tokenRepository.save(token);
        return jwt;
    }
    public void deactivateTokens(String nickname){
        Long id= userRepository.getUserId(nickname);
        tokenRepository.deactiveAll(id);
    }

    public String renewToken(String nickname) {
        var user = User.builder()
                .nickname(nickname)
                .build();
        return "{\"token\":\""+generateToken(user)+"\"}";
    }
}

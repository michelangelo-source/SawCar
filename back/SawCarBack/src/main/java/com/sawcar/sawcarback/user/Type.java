package com.sawcar.sawcarback.user;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static com.sawcar.sawcarback.user.Permission.*;
@RequiredArgsConstructor
public enum Type {
    USER(Collections.emptySet()),
    MODERATOR(
            Set.of(
                    MODERATOR_READ,
                    MODERATOR_UPDATE,
                    MODERATOR_DELETE,
                    MODERATOR_CREATE
            )
    ),
    ADMIN(
            Set.of(
                    ADMIN_READ,
                    ADMIN_UPDATE,
                    ADMIN_DELETE,
                    ADMIN_CREATE,
                    MODERATOR_READ,
                    MODERATOR_UPDATE,
                    MODERATOR_DELETE,
                    MODERATOR_CREATE
            )
    );
    @Getter
    private final Set<Permission> permissions;
    public List<SimpleGrantedAuthority> getAuthorities() {
        var authorities = getPermissions()
                .stream()
                .map(permission -> new SimpleGrantedAuthority(permission.getPermission()))
                .collect(Collectors.toList());
        authorities.add(new SimpleGrantedAuthority("ROLE_" + this.name()));
        return authorities;
    }
}

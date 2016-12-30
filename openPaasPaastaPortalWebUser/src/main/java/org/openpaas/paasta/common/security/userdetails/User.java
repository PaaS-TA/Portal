package org.openpaas.paasta.common.security.userdetails;

import org.springframework.security.core.CredentialsContainer;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.util.Assert;

import java.io.Serializable;
import java.util.*;

/**
 * Models core user information retrieved by a {@link UserDetailsService}.
 * <p>
 * Developers may use this class directly, subclass it, or write their own {@link UserDetails} implementation from
 * scratch.
 * <p>
 * {@code equals} and {@code hashcode} implementations are based on the {@code username} property only, as the
 * intention is that lookups of the same user principal object (in a user registry, for example) will match
 * where the objects represent the same user, not just when all the properties (authorities, password for
 * example) are the same.
 * <p>
 * Note that this implementation is not immutable. It implements the {@code CredentialsContainer} interface, in order
 * to allow the password to be erased after authentication. This may cause side-effects if you are storing instances
 * in-memory and reusing them. If so, make sure you return a copy from your {@code UserDetailsService} each time it is
 * invoked.
 *
 * @author Ben Alex
 * @author Luke Taylor
 *
 * 스프링 시큐리티에서 사용하는 UserDetails를 구현한 구현체.
 * 로그인한 사용자에 대한 정보를 담은 클레스.
 * 스프링 시큐리티는 이 정보를 세션에 담아 관리한다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016-05-13
 */
public class User implements UserDetails, CredentialsContainer {

    private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;

    //~ Instance fields ================================================================================================
    private String password;
    private String token;
    private String name;
    private Long expireDate;
    private String imgPath;
    private final String username;
    private final Set<GrantedAuthority> authorities;
    private final boolean accountNonExpired;
    private final boolean accountNonLocked;
    private final boolean credentialsNonExpired;
    private final boolean enabled;

    //~ 생성자 ===================================================================================================

    /**
     * Calls the more complex constructor with all boolean arguments set to {@code true}.
     */
    public User(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        this(username, password, true, true, true, true, authorities);
    }
    /**
     * <code>User</code> 의 생성자
     * {@link org.springframework.security.authentication.dao.DaoAuthenticationProvider}.
     *
     * @param username              <code>DaoAuthenticationProvider</code> 으로 표현된 사용자이름
     * @param password              <code>DaoAuthenticationProvider</code>으로 표현된 사용자 패스워드
     * @param enabled               <code>true</code> 사용자 사용여부
     * @param accountNonExpired     <code>true</code>  계정
     * @param credentialsNonExpired <code>true</code> 크레덴셜
     * @param accountNonLocked      <code>true</code>  잠금 여부
     * @param authorities           사용자 패스워드를 통한 권한
     * @throws IllegalArgumentException <code>null</code> 패스워드가 null이거나 파라메터나 <code>GrantedAuthority</code> collection이 null일 경우 예외를 발생시킨다.
     */
    public User(String username, String password, boolean enabled, boolean accountNonExpired,
                boolean credentialsNonExpired, boolean accountNonLocked, Collection<? extends GrantedAuthority> authorities) {

        if (((username == null) || "".equals(username)) || (password == null)) {
            throw new IllegalArgumentException("Cannot pass null or empty values to constructor");
        }

        this.username = username;
        this.password = password;
        this.enabled = enabled;
        this.accountNonExpired = accountNonExpired;
        this.credentialsNonExpired = credentialsNonExpired;
        this.accountNonLocked = accountNonLocked;
        this.authorities = Collections.unmodifiableSet(sortAuthorities(authorities));
    }

    //~ Methods ========================================================================================================

    public Collection<GrantedAuthority> getAuthorities() {
        return authorities;
    }

    /**
     * 모델 user의 패스워드를 String 객체로 보내준다
     *
     * @return String
     */
    public String getPassword() {
        return password;
    }

    /**
     * <pre>
     * 모델 user의 사용자 이름을 String 객체로 보내준다
     * </pre>
     * @return String
     */
    public String getUsername() {
        return username;
    }

    /**
     * <pre>
     * 모델 user의 사용여부를 boolean 객체로 보내준다
     * </pre>
     * @return String
     */
    public boolean isEnabled() {
        return enabled;
    }

    /**
     * <pre>
     * 모델 user의 계정 만료여 부를 boolean 객체로 보내준다
     * </pre>
     * @return String
     */
    public boolean isAccountNonExpired() {
        return accountNonExpired;
    }

    /**
     * <pre>
     * 모델 user의 계정 만료여부를 boolean 객체로 보내준다
     * </pre>
     * @return String
     */
    public boolean isAccountNonLocked() {
        return accountNonLocked;
    }

    /**
     * <pre>
     * 모델 user의  크레덴셜 만료여부를 boolean 객체로 보내준다
     * </pre>
     * @return String
     */
    public boolean isCredentialsNonExpired() {
        return credentialsNonExpired;
    }

    /**
     * <pre>
     * 모델 user의 크레덴셜을 삭제.
     * </pre>
     * @return String
     */
    public void eraseCredentials() {
        //password = null;
    }

    /**
     * <pre>
     * Collection 객체  GrantedAuthority를 정렬한다.
     * </pre>
     * @param authorities
     * @return
     */
    private static SortedSet<GrantedAuthority> sortAuthorities(Collection<? extends GrantedAuthority> authorities) {
        Assert.notNull(authorities, "Cannot pass a null GrantedAuthority collection");
        // Ensure array iteration order is predictable (as per UserDetails.getAuthorities() contract and SEC-717)
        SortedSet<GrantedAuthority> sortedAuthorities =
                new TreeSet<GrantedAuthority>(new AuthorityComparator());

        for (GrantedAuthority grantedAuthority : authorities) {
            Assert.notNull(grantedAuthority, "GrantedAuthority list cannot contain any null elements");
            sortedAuthorities.add(grantedAuthority);
        }

        return sortedAuthorities;
    }

    /**
     * Gets token.
     * <pre>
     * User 모델에서 String token 객체를 가져온다.
     * </pre>
     * @return String token
     */
    public String getToken() {
        return token;
    }

    /**
     * Gets name.
     *
     * @return the name
     */
    public void setToken(String token) {
        this.token = token;
    }

    /**
     * Sets name.
     *
     * @param name the name
     */
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Long expireDate) {
        this.expireDate = expireDate;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    private static class AuthorityComparator implements Comparator<GrantedAuthority>, Serializable {
        private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;

        public int compare(GrantedAuthority g1, GrantedAuthority g2) {
            // Neither should ever be null as each entry is checked before adding it to the set.
            // If the authority is null, it is a custom authority and should precede others.
            if (g2.getAuthority() == null) {
                return -1;
            }

            if (g1.getAuthority() == null) {
                return 1;
            }

            return g1.getAuthority().compareTo(g2.getAuthority());
        }
    }

    /**
     * Returns {@code true} if the supplied object is a {@code User} instance with the
     * same {@code username} value.
     * <p>
     * In other words, the objects are equal if they have the same username, representing the
     * same principal.
     */
    @Override
    public boolean equals(Object rhs) {
        if (rhs instanceof User) {
            return username.equals(((User) rhs).username);
        }
        return false;
    }

    /**
     * Returns the hashcode of the {@code username}.
     */
    @Override
    public int hashCode() {
        return username.hashCode();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(super.toString()).append(": ");
        sb.append("Username: ").append(this.username).append("; ");
        sb.append("Password: [PROTECTED]; ");
        sb.append("Enabled: ").append(this.enabled).append("; ");
        sb.append("AccountNonExpired: ").append(this.accountNonExpired).append("; ");
        sb.append("credentialsNonExpired: ").append(this.credentialsNonExpired).append("; ");
        sb.append("AccountNonLocked: ").append(this.accountNonLocked).append("; ");

        if (!authorities.isEmpty()) {
            sb.append("Granted Authorities: ");

            boolean first = true;
            for (GrantedAuthority auth : authorities) {
                if (!first) {
                    sb.append(",");
                }
                first = false;

                sb.append(auth);
            }
        } else {
            sb.append("Not granted any authorities");
        }

        return sb.toString();
    }
}
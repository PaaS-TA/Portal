package org.openpaas.paasta.portal.web.user.config.security;

/**
 * 스프링 시큐리티의 사용자 인증방식을 구현한 클래스
 * 기존의 id를 이용하여 Password를 비교하여 인증하는 방식대신
 * PaaS-TA API의 Login 을 사용하여 인증하도록 수정하였다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016-05-12
 */
import org.openpaas.paasta.portal.web.user.config.security.userdetail.CustomUserDetailsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.Collection;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {
    private static final Logger LOGGER = LoggerFactory.getLogger(CustomAuthenticationProvider.class);

    @Autowired
    CustomUserDetailsService customUserDetailsService;
/*

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
*/

	/**
	 * 로그인 폼에서 입력받은 id와 password를 이용하여 사용자 인증을 수행하는 메소드
	 *
	 * @param authentication
	 * @return Authentication 사용자 인증정보
	 * @throws AuthenticationException
	 */
    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String username = authentication.getName();
        String password = (String) authentication.getCredentials();

        Collection<? extends GrantedAuthority> authorities = null;

        UserDetails user = null;

        try {

            user = customUserDetailsService.loginByUsernameAndPassword(username, password);

            LOGGER.info("username : " + username + " / password : " + password );

            // matches 를 이용하여 암호를 비교한다.
            if ( !password.equals(user.getPassword()) ) {
                throw new BadCredentialsException( "암호가 일치하지 않습니다." );
            }

            authorities = user.getAuthorities();
        } catch(UsernameNotFoundException e) {
            LOGGER.info(e.toString());
            throw new UsernameNotFoundException(e.getMessage());
        } catch(BadCredentialsException e) {
            LOGGER.info(e.toString());
            throw new BadCredentialsException(e.getMessage());
        } catch(Exception e) {
            LOGGER.info(e.toString());
        }

        return new UsernamePasswordAuthenticationToken(user, password, authorities);
    }

    @Override
    public boolean supports(Class<?> arg0) {
        return true;
    }
}
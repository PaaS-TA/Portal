package org.openpaas.paasta.portal.web.user.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

/**
 * The type Security config.
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	/**
	 * Configure global.
	 *
	 * @param authenticationMgr the authentication mgr
	 * @the exception
	 */

	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder authenticationMgr) {

        authenticationMgr.authenticationProvider(customAuthenticationProvider());
	}

    @Bean
    AuthenticationProvider customAuthenticationProvider() {

        CustomAuthenticationProvider impl = new CustomAuthenticationProvider();
        return impl ;
    }

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
				.csrf().disable()
				.authorizeRequests()
					.antMatchers("/").permitAll()
					.antMatchers("/index").permitAll()
					.antMatchers("/invitations/*").permitAll()
					.antMatchers("/main").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
					.antMatchers("/org/*").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
					.antMatchers("/space/*").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
					.antMatchers("/app/*").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
					.antMatchers("/user/authResetPassword").permitAll()
					.antMatchers("/user/authPassword").permitAll()
					.antMatchers("/user/authUser").permitAll()
					.antMatchers("/user/authErrorUser").permitAll()
					.antMatchers("/user/resetPassword").permitAll()
					.antMatchers("/user/addUser").permitAll()
					.antMatchers("/user/authUpdateUser").permitAll()
					.antMatchers("/requestEmailAuthentication").permitAll()
					.antMatchers("/user/*").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
					.antMatchers("/main/userPage").access("hasRole('ROLE_USER')")
					.antMatchers("/main/adminPage").access("hasRole('ROLE_ADMIN')")
					.and()
					.formLogin().loginPage("/login")
					.defaultSuccessUrl("/org/orgMain")
					.failureUrl("/login?error")
					.usernameParameter("id").passwordParameter("password")
					.and()
					.logout().logoutSuccessUrl("/index");


	}

}

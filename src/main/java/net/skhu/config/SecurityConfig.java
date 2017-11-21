package net.skhu.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import net.skhu.service.MyAuthenticationProvider;

@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired MyAuthenticationProvider myAuthenticationProvider;

	@Override
	public void configure(WebSecurity web) throws Exception {
		// /res/** 패턴의 url은 보안 검사를 하지 않고 무시하라는 설정. ( ignoring() )
		web.ignoring().antMatchers("/res/**");
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// ( authorizeRequests() ) 권한 설정 시작
		http.authorizeRequests()
			.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")										// /admin/** 패턴의 url은 ADMIN 권한만 허용
			.antMatchers("/mentor/**").access("hasRole('ROLE_MENTOR') and hasRole('ROLE_ADMIN')")
			.antMatchers("/guest/**").permitAll()															// /guest/** 패턴의 url은 모든 사용자 허용
			.antMatchers("/").permitAll()																	// / url은 모든 사용자 허용
			.antMatchers("/**").authenticated();															// /** 패턴의 url은 로그인된 사용자만 허용

		http.csrf().disable();		// CSRF 공격 검사를 하지 않겠다는 설정. (나중에 해야함)

		// ( formLogin() ) 로그인 페이지 설정 시작
		http.formLogin()
			.loginPage("/guest/login")
			.loginProcessingUrl("/guest/login_processing")
			.failureUrl("/guest/login?error")
			.defaultSuccessUrl("/user/index", true)
			.usernameParameter("userId")
			.passwordParameter("passwd");

		// ( (logout() ) 로그아웃 설정 시작
		http.logout().logoutRequestMatcher(new AntPathRequestMatcher("/user/logout_processing"))
					 .logoutSuccessUrl("/guest/index")
					 .invalidateHttpSession(true);		// 로그아웃할 때 Session에 들어있는 데이터를 전부 지우라는 설정

		http.authenticationProvider(myAuthenticationProvider);
	}
}
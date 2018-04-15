package net.skhu.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import net.skhu.dto.User;

// 사용자가 입력한 로그인 ID와 Password를 검사할 때 사용되는 클래스
@Component
public class MyAuthenticationProvider implements AuthenticationProvider {

	@Autowired UserService userService;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String userId = authentication.getName();
		String passwd = authentication.getCredentials().toString();
		return authenticate(userId, passwd);
	}

	// 사용자가 입력한 ID와 Password를 검사해야 할 때 Spring Security 엔진에 의해 이 클래스의 authenticate 메소드가 자동으로 호출된다.
	public Authentication authenticate(String userId, String password) throws AuthenticationException {

		// ID와 Password 검사
		User user = userService.login(userId, password);

		// 실패하면 null 리턴
		if (user == null) return null;

		List<GrantedAuthority> grantedAuthorities = new ArrayList<GrantedAuthority>();
		String role = "";
		switch (user.getAuthority()) {
		case "3":
			role = "ROLE_ADMIN";
			break;
		case "2":
			role = "ROLE_MENTOR";
			break;
		case "1":
			role = "ROLE_MENTEE";
			break;
		}
		System.out.println("**********************user.getAuthority: "+ user.getAuthority());

		grantedAuthorities.add(new SimpleGrantedAuthority(role));
		return new MyAuthentication(userId, password, grantedAuthorities, user);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

	public class MyAuthentication extends UsernamePasswordAuthenticationToken {
		private static final long serialVersionUID = 1L;
		User user;

		public MyAuthentication(String userId, String passwd, List<GrantedAuthority> grantedAuthorities, User user) {
			super(userId, passwd, grantedAuthorities);
			this.user = user;
		}

		public User getUser() {
			return user;
		}

		public void setUser(User user) {
			this.user = user;
		}
	}
}

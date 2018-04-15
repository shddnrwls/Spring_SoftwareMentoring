package net.skhu.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import net.skhu.dto.User;
import net.skhu.repository.UserRepository;

@Service
public class UserService {

	@Autowired UserRepository userRepository;

	// login 메소드 (사용자가 입력한 로그인 ID와 Password를 검사하는 메소드)
	public User login(String userId, String password) {

		User user = userRepository.findOneByUserId(userId);

		if (user == null) return null;

		// String pw = Encryption.encrypt(password, Encryption.MD5);	// 암호화하는 부분
		if (user.getPassword().equals(password) == false) return null;

		// 검사 결과가 성공이면 User 테이블에서 조회한 user 객체를 리턴한다.
		return user;
	 }

	public static User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication instanceof MyAuthenticationProvider.MyAuthentication)
            return ((MyAuthenticationProvider.MyAuthentication) authentication).getUser();
        return null;
    }

    public static void setCurrentUser(User user) {
        ((MyAuthenticationProvider.MyAuthentication)
                SecurityContextHolder.getContext().getAuthentication()).setUser(user);
    }

}

package link.duoyu.note.service.impl;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import link.duoyu.note.service.PasswordService;
import org.springframework.stereotype.Service;

/**
 * PasswordServiceImpl
 *
 * @author Izcw
 * @Date 2024/11/7 下午8:03
 */
@Service
public class PasswordServiceImpl implements PasswordService {
    private final Argon2 argon2 = Argon2Factory.create();

    @Override
    public String hashPassword(String password) {
        return argon2.hash(2, 65536, 1, password.toCharArray());
    }

    @Override
    public boolean verifyPassword(String inputPassword, String storedHash) {
        return argon2.verify(storedHash, inputPassword.toCharArray());
    }
}
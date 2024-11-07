package link.duoyu.system.service;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;

/**
 * PasswordService
 *
 * @author Izcw
 * @Date 2024/11/7 下午7:57
 */
public interface PasswordService {
    String hashPassword(String password);
    boolean verifyPassword(String inputPassword, String storedHash);
}
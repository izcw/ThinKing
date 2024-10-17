package com.eleadmin.common.core.config;

import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.TenantLineInnerInterceptor;
import com.eleadmin.common.system.entity.User;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.LongValue;
import net.sf.jsqlparser.expression.NullValue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Arrays;

/**
 * MybatisPlus配置
 *
 * @author EleAdmin
 * @since 2018-02-22 11:29:28
 */
@Configuration
public class MybatisPlusConfig {

    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();

        // 多租户插件配置
        TenantLineHandler tenantLineHandler = new TenantLineHandler() {
            @Override
            public Expression getTenantId() {
                return getLoginUserTenantId();
            }

            @Override
            public boolean ignoreTable(String tableName) {
                return Arrays.asList(
                        "sys_tenant",
                        "sys_dictionary",
                        "sys_dictionary_data"
                ).contains(tableName);
            }
        };
        TenantLineInnerInterceptor tenantLineInnerInterceptor = new TenantLineInnerInterceptor(tenantLineHandler);
        interceptor.addInnerInterceptor(tenantLineInnerInterceptor);

        // 分页插件配置
        PaginationInnerInterceptor paginationInnerInterceptor = new PaginationInnerInterceptor();
        interceptor.addInnerInterceptor(paginationInnerInterceptor);

        return interceptor;
    }

    /**
     * 获取当前登录用户的租户id
     *
     * @return Integer
     */
    public Expression getLoginUserTenantId() {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null) {
                Object object = authentication.getPrincipal();
                if (object instanceof User) {
                    return new LongValue(((User) object).getTenantId());
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return new NullValue();
    }

}

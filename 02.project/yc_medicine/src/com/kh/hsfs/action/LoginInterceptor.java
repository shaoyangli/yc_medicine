package com.kh.hsfs.action;

import java.util.Map;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class LoginInterceptor extends AbstractInterceptor {
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		// 把loginaction给排除掉让它可以登录
		/*System.out.println((LoginAction.class == invocation.getAction().getClass())+"------------");
		if (LoginAction.class == invocation.getAction().getClass()) {
			return invocation.invoke();
		}

		Map map = invocation.getInvocationContext().getSession();

		if (null == map.get("user")) {
			return "nouser";
		}
*/
		return invocation.invoke();
	}

}

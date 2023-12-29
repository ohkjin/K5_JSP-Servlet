package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.http.HttpServletRequest;

//@WebFilter(*): for all
@WebFilter(urlPatterns="/15FilterListener/BasicFilter.jsp", 
		   initParams= {
				   @WebInitParam(name="FILTER_INIT_PARAM", value="필터 초기화 매개변수")
		   })

public class BasicFilter implements Filter {
	FilterConfig config;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		config = filterConfig;
		String filterName = filterConfig.getFilterName();
		System.out.println("BasicFilter -> init() 호출됨 : "+ filterName);
	}
	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		String filterInitParam = config.getInitParameter("FILTER_INIT_PARAM");
		System.out.println("BasicFilter -> 초기화 매개변수 : "+ filterInitParam);
		
		//String method = request.getMethod(); ERROR(Able to summon after type casting)
		String method = ((HttpServletRequest)req).getMethod();
		System.out.println("BasicFilter -> 전송 방식 : "+ method);
		
		chain.doFilter(req, resp);
	}
	@Override
	public void destroy() {
		System.out.println("BasicFilter -> destroy() 호출됨");
	}
}

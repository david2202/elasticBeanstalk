package au.org.howe.ebdemo.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.naming.NamingException;
import java.util.Date;
import java.util.Map;

@Controller
public class HomeController {

    @Lazy
    @Autowired
    private javax.naming.Context context;

    @RequestMapping("/")
    public ModelAndView welcome(ModelAndView mav) throws NamingException {
        String value = context.lookup("apEnvironment").toString();
        mav.addObject("environment", value);
        mav.setViewName("welcome");
        return mav;
    }
}

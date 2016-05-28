package au.org.howe.ebdemo.web;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.Map;

@Controller
public class HomeController {
    @RequestMapping("/")
    public String welcome() {
        return "welcome";
    }
}

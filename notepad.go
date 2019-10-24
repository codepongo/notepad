package main

import (
    "flag"
    "fmt"
    "html/template"
    "net/http"
    "github.com/codepongo/notepad/libsession"
    "github.com/codepongo/notepad/libwmd"
)

var cookieName = "notepad.zuohaitao.com"
var session = libsession.NewlibSession(cookieName, 3600)


func main() {
    var port string
    flag.StringVar(&port, "port", "8080", "port to run on")
    flag.Parse()
    http.Handle("/style/css/", http.FileServer(http.Dir(".")))
    http.Handle("/style/js/", http.FileServer(http.Dir(".")))
    http.Handle("/style/image/", http.FileServer(http.Dir(".")))
    libwmd.Handlers()
    http.HandleFunc("/login", login)
    http.HandleFunc("/logout", logout)
    http.HandleFunc("/wmd", wmd)
    http.HandleFunc("/", index)
    fmt.Println("Listenning on" + port)
    http.ListenAndServe(":"+port, nil)
}

func wmd(w http.ResponseWriter, r *http.Request) {
    var sessionID = session.CheckCookieValid(w, r)
    if sessionID == "" {
        http.Redirect(w, r, "/login", http.StatusFound)
        return
    }
    libwmd.Handle(w, r)
}

func index(w http.ResponseWriter, r *http.Request) {
    var sessionID = session.CheckCookieValid(w, r)
    if sessionID == "" {
        http.Redirect(w, r, "/login", http.StatusFound)
        return
    }
    tmpl := `<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> <title>Go Web Programming</title>
    </head>
    <body>
        <h1><a href="/logout">logout</a></h1>

    </body>
</html>`
    t := template.New("index")
    t, _ = t.Parse(tmpl)
    t.Execute(w, nil)
}

func validate(user, password string) bool {
    return true
}


func login(w http.ResponseWriter, r *http.Request) {
    const sessionKey = "context"
    if r.Method == "GET" {
        t, err := template.ParseFiles("views/login.html")
        if t == nil {
            fmt.Println(err)
            return
        }
        t.Execute(w, nil)
    } else if r.Method == "POST" {
        r.ParseForm()
        userName := r.FormValue("name")
        password := r.FormValue("password")

        valid := validate(userName, password)

        if !valid {
            return
        }
        var sessionID = session.StartSession(w, r)

        //kick out the last user
        var onlineSessionIDList = session.GetSessionIDList()

        for _, onlineSessionID := range onlineSessionIDList {
            if ctx, ok := session.GetSessionVal(onlineSessionID, sessionKey); ok {
                if curName, ok := ctx.(string); ok {
                    if curName  == userName {
                        session.EndSessionBy(onlineSessionID)
                    }
                }
            }
        }

        //set session
        session.SetSessionVal(sessionID, "context", userName)

        //redirect
        http.Redirect(w, r, "/wmd", http.StatusFound)

        return
    }
}


func logout(w http.ResponseWriter, r *http.Request) {
    session.EndSession(w, r) //用户退出时删除对应session
    http.Redirect(w, r, "/login", http.StatusFound)
    return
}

package libwmd

import (
    "fmt"
    "net/http"
    "html/template"

)

func Handle(w http.ResponseWriter, r *http.Request) {
    if r.Method == "GET" {
        t, err := template.ParseFiles("libwmd/views/wmd-test.tpl")
        if t == nil {
            fmt.Println(err)
            return
        }
        t.Execute(w, nil)
    } else if r.Method == "POST" {
        r.ParseForm()
        userName := r.FormValue("name")
        password := r.FormValue("password")
        _, _ = userName, password

        //redirect
        http.Redirect(w, r, "/wmd", http.StatusFound)

        return
    }
}

func Handlers() {
    fs := http.FileServer(http.Dir("libwmd"))
    http.Handle("/wmd/showdown.js", http.StripPrefix("/wmd", fs))
    http.Handle("/wmd/wmd.css", http.StripPrefix("/wmd", fs))
    http.Handle("/wmd/wmd.js", http.StripPrefix("/wmd", fs))
}

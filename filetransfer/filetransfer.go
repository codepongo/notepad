package filetransfer

import (
	"net/http"
)

func Handlers() {
    fs := http.FileServer(http.Dir("filetransfer"))
    http.Handle("/filetransfer/upload.css", http.StripPrefix("/upload", fs))
	http.Handle("/filetransfer/upload.js", http.StripPrefix("/upload", fs))
    http.Handle("/filetransfer/put")
    http.Hanlde("")
}
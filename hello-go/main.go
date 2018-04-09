package main

import (
	"net/http"
	"log"
)

const (
	Message = "Hello world"
)

func main() {
	http.HandleFunc("/hello", func(w http.ResponseWriter, req *http.Request) {
		log.Print(Message)
		w.Write([]byte(Message))
	})

	log.Print("hello go starts!")
	http.ListenAndServe(":5000", nil)
}

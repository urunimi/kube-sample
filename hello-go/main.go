package main

import (
	"net/http"
	"log"
	"math"
)

const (
	Message = "Hello world\n"
)

func main() {
	http.HandleFunc("/hello", func(w http.ResponseWriter, req *http.Request) {
		w.Write([]byte(Message))
	})

	http.HandleFunc("/foo", func(w http.ResponseWriter, req *http.Request) {
		x := 0.0
		for i := 0; i < 1000000; i++ {
			x += math.Sqrt(float64(i))
		}
		w.Write([]byte(Message))
	})

	log.Print("hello go starts!")
	http.ListenAndServe(":5000", nil)
}

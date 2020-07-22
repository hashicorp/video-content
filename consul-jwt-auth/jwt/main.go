package main

import (
	"crypto/rsa"
	"crypto/x509"
	"encoding/pem"
	"fmt"
	"io/ioutil"
	"os"
	"time"

	"gopkg.in/jose.v1/crypto"
	"gopkg.in/jose.v1/jws"
)

func main() {
	var rsaPriv *rsa.PrivateKey

	der, err := ioutil.ReadFile("./private.pem")
	if err != nil {
		panic(err)
	}
	block2, _ := pem.Decode(der)

	rsaPriv, err = x509.ParsePKCS1PrivateKey(block2.Bytes)
	if err != nil {
		panic(err)
	}

	var claims = jws.Claims{
		"service": "Nic",
		"admin":   true,
		"iss":     "test.com",
		"iat":     time.Now().Add(-1 * time.Hour).Unix(),
		"nbf":     time.Now().Add(-1 * time.Hour).Unix(),
		"exp":     time.Now().Add(36000 * time.Hour).Unix(),
	}

	j := jws.NewJWT(claims, crypto.SigningMethodRS512)
	b, err := j.Serialize(rsaPriv)
	if err != nil {
		panic(err)
	}

	ioutil.WriteFile("./jwt.token", b, os.ModePerm)
	fmt.Println(string(b))
}

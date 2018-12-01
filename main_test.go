// Copyright (C) 2018 Michael Joseph Walsh - All Rights Reserved
// You may use, distribute and modify this code under the
// terms of the the license.
//
// You should have received a copy of the license with
// this file. If not, please email <mjwalsh@nemonik.com>

package main

import (
        "os"
        "testing"
)

func TestMain(m *testing.M) {
        os.Exit(m.Run())
}

func TestHelloWorld(t *testing.T) {
        if HelloWorld() != "hello world" {
                t.Errorf("got %s expected %s", HelloWorld(), "hello world")
        }
}

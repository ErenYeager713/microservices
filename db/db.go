package db

import (
	"fmt"
	"log"

	"gopkg.in/mgo.v2"
)

type Connection interface{}

type conn struct {
	session  *mgo.Session
	database *mgo.Database
}

func NewConnection(cfg Config) (Connection, error) {
	fmt.Printf("database url:", cfg.Dsn())
	session, err := mgo.Dial(cfg.Dsn())
	if err != nil {
		log.Fatal(err)
	}

	return &conn{session: session, database: session.DB(cfg.DbName())}, nil
}

func (c *conn) Close() {
	c.session.Close()
}

func (c *conn) DB() *mg.Database {
	return c.database
}

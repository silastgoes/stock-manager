package uwo

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
)

type RepositoryFactory func(tx *sql.Tx) interface{}

type UowInterface interface {
	Register(name string, fc RepositoryFactory)
	GetRepository(ctx context.Context, name string) (interface{}, error)
	Do(ctx context.Context, fn func(uow UowInterface) error) error
	CommitOrRollback() error
	Rollback() error
	UnRegister(name string)
}

type Uow struct {
	DB           *sql.DB
	TX           *sql.Tx
	Repositories map[string]RepositoryFactory
}

func NewUow(ctx context.Context, db *sql.DB) UowInterface {
	return &Uow{
		DB:           db,
		Repositories: make(map[string]RepositoryFactory),
	}
}

// CommitOrRollback implements UowInterface.
func (u *Uow) CommitOrRollback() error {
	if u.TX == nil {
		return errors.New("no transaction started")
	}
	if err := u.TX.Commit(); err != nil {
		u.TX.Rollback()
		return err
	}
	return nil
}

// Do implements UowInterface.
func (u *Uow) Do(ctx context.Context, fn func(uow UowInterface) error) error {
	if u.TX != nil {
		return errors.New("trasaction already started")
	}
	tx, err := u.DB.BeginTx(ctx, nil)
	if err != nil {
		return err
	}
	u.TX = tx

	if err := fn(u); err != nil {
		if errRB := u.TX.Rollback(); errRB != nil {
			return fmt.Errorf("orinal error: %s, rollback error: %s", err.Error(), errRB.Error())
		}
		return err
	}

	return u.CommitOrRollback()
}

// GetRepository implements UowInterface.
func (u *Uow) GetRepository(ctx context.Context, name string) (interface{}, error) {
	factory, exists := u.Repositories[name]
	if !exists {
		return nil, errors.New("repository not registered")
	}
	return factory(u.TX), nil
}

// Register implements UowInterface.
func (u *Uow) Register(name string, fc RepositoryFactory) {
	u.Repositories[name] = fc
}

// Rollback implements UowInterface.
func (u *Uow) Rollback() error {
	if u.TX == nil {
		return errors.New("no transaction started")
	}
	return u.TX.Rollback()
}

// UnRegister implements UowInterface.
func (u *Uow) UnRegister(name string) {
	delete(u.Repositories, name)
}

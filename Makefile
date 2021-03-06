APP=ebi_core
REBAR=rebar


all: compile-all

deps:
	$(REBAR) get-deps

compile:
	$(REBAR) compile apps=$(APP)

compile-all:
	$(REBAR) compile

run:
	env ERL_LIBS=deps erl -pa ebin -config priv/test -eval 'ebi:start().'

check: test itest

test: compile
	$(REBAR) eunit apps=$(APP) verbose=1 

itest: compile
	$(REBAR) ct apps=$(APP)

doc:
	$(REBAR) doc

clean:
	$(REBAR) clean apps=$(APP)

clean-all:
	$(REBAR) clean
	rm -f itest/*.beam

.PHONY: all deps compile compile-all run check test itest doc clean clean-all


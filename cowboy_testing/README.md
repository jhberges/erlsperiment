Experiments in Cowboy!
============
Following the guide from the cowboy project:
# wgot erlang.mk from https://raw.githubusercontent.com/ninenines/erlang.mk/master/erlang.mk
# made make -f erlang.mk bootstrap bootstrap-rel
# Added cowboy as dependency (note: project names CANNOT have hyphens)
# Added a REST handler via update to the _app.erl file + make new t=cowboy_rest n=cowboy_testing_handler

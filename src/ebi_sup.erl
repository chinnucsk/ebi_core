%
% Copyright 2012-2013 Karolis Petrauskas
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%     http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
%
-module(ebi_sup).
-behaviour(supervisor).
-export([start_link/1]).
-export([init/1]).

-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%%
%%  Start supervisor.
%%
start_link(_Config) -> % XXX: pass config further.
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%
%%  Configure supervisor.
%%
init(_Args) ->
    {ok, {{one_for_one, 1, 60}, [
        {ebi, {ebi, start_link, []}, permanent, brutal_kill, worker, [ebi]}
    ]}}.

%%  
%%  Copyright 2013, Andreas Stenius <kaos@astekk.se>
%%  
%%   Licensed under the Apache License, Version 2.0 (the "License");
%%   you may not use this file except in compliance with the License.
%%   You may obtain a copy of the License at
%%  
%%     http://www.apache.org/licenses/LICENSE-2.0
%%  
%%   Unless required by applicable law or agreed to in writing, software
%%   distributed under the License is distributed on an "AS IS" BASIS,
%%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%   See the License for the specific language governing permissions and
%%   limitations under the License.
%%  

-module(ecapnp).
-author("Andreas Stenius <kaos@astekk.se>").

-export([get_root/3, get/2]).
-export([set_root/2, set/3]).

-include("ecapnp.hrl").

%% ===================================================================
%% API functions
%% ===================================================================

get_root(Type, Schema, [Segment|_]=Segments) 
  when is_atom(Type),
       is_record(Schema, schema),
       is_binary(Segment) ->
    ecapnp_get:root(Type, Schema, Segments).

set_root(Type, Schema)
  when is_atom(Type),
       is_record(Schema, schema) ->
    ecapnp_set:root(Type, Schema).

get(Field, #object{ type=#struct{
                            fields=Fields
                           }}=Object)
  when is_atom(Field) ->
    ecapnp_get:field(
      proplists:get_value(Field, Fields),
      Object
     ).

set(Field, Value, #object{ type=#struct{
                                   fields=Fields
                                  }}=Object)
  when is_atom(Field) ->
    ecapnp_set:field( 
      proplists:get_value(Field, Fields),
      Value, Object
     ).


%% ===================================================================
%% internal functions
%% ===================================================================

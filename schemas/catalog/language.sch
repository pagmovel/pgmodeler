# Catalog queries for languages
# CAUTION: Do not modify this file unless you know what you are doing.
#          Code generation can be broken if incorrect changes are made.

%if @{list} %then
  [SELECT oid, lanname AS name FROM pg_language ]

  %if @{last-sys-oid} %then
   [ WHERE oid > ] @{last-sys-oid}
  %end

  %if @{from-extension} %then
    %if @{last-sys-oid} %then
      [ AND ]
    %else
     [ WHERE ]
    %end
    ( @{from-extension} ) [ IS FALSE ]
  %end

%else
    %if @{attribs} %then
      [SELECT oid, lanname AS name, lanpltrusted AS trusted_bool,
	      lanplcallfoid AS handler_func, laninline AS inline_func,
	      lanvalidator AS validator_func, lanacl AS permissions, lanowner AS owner, ]

      (@{comment}) [ AS comment ]

      [ FROM pg_language WHERE  lanispl IS TRUE ]

       %if @{last-sys-oid} %then
	 [ AND oid > ] @{last-sys-oid}
       %end

       %if @{from-extension} %then
	 [ AND ] ( @{from-extension} ) [ IS FALSE ]
       %end

       %if @{filter-oids} %then
	 [ AND oid IN (] @{filter-oids} )
       %end
    %end
%end
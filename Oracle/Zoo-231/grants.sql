declare
    cmd string(120);
begin
    for r in ( select object_name
               from user_objects
               where object_type in ('TABLE','MATERIALIZED VIEW','VIEW','SEQUENCE') )
        loop
            cmd := 'grant select on '||r.object_name||' to Guest, Guest_AC, Guest_AD, Guest_AX';
            execute immediate cmd;
        end loop;
    for r in ( select object_name
               from user_objects
               where object_type in ('PACKAGE','PROCEDURE','FUNCTION') )
        loop
            cmd := 'grant execute on '||r.object_name||' to Guest, Guest_AC, Guest_AD, Guest_AX';
            execute immediate cmd;
        end loop;
end;
/

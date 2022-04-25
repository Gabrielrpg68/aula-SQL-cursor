set SERVEROUTPUT on;


select sysdate from dual;

create table t_funcionario(cd_fun number(2) primary key, nm_fun VARCHAR2(50), salario number(10,2), dt_adm DATE);
drop table t_funcionario;
select * from t_funcionario;
begin
    insert into t_funcionario values(1, 'Marcel', 100000, '14-APR-2000');
    insert into t_funcionario values(2, 'Claudia', 160000, '02-OCT-1998');
    insert into t_funcionario values(3, 'Joaquim', 5500, '10-JUL-2010');
    insert into t_funcionario values(4, 'Valeria', 7300, '08-JUN-2015');
commit;
end;

declare
    cursor c_exibe is select nm_fun, salario from t_funcionario;
    v_exibe c_exibe%rowtype;
begin
    open c_exibe;
    loop
        fetch c_exibe into v_exibe;
    exit when c_exibe%notfound;
    dbms_output.put_line('Nome: ' || v_exibe.nm_fun || ' - Salário:' ||v_exibe.salario);
    end loop;
    close c_exibe;
end;

declare
    cursor C_exibe IS SELECT nm_fun, salario from t_funcionario;
begin
    for v_exibe in c_exibe loop
        dbms_output.put_line('Nome: ' || v_exibe.nm_fun|| ' - Salário : ' || v_exibe.salario);
    end loop;
end;

alter table t_funcionario add (tempo number(6));

declare
    dt_atual DATE;
    cursor c_exibe IS SELECT * from t_funcionario;
begin
    for v_exibe in c_exibe loop
        update t_funcionario set tempo = sysdate - v_exibe.dt_adm where cd_fun = v_exibe.cd_fun;
    end loop;
end;

declare
    dias number(6) := 150 * 30;
    cursor c_exibe is select * from t_funcionario;
begin
    for v_exibe in c_exibe loop
        if v_exibe.tempo > dias then
            update t_funcionario set salario = salario + salario * 0.1 where cd_fun = v_exibe.cd_fun;
        else
            update t_funcionario set salario = salario + salario * 0.05 where cd_fun = v_exibe.cd_fun;
        end if;
    end loop;
end;

select * from t_funcionario;
    
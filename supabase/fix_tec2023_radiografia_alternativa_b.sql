-- TEC 2023, tema Válvula: "Assinale o diagnóstico mais provável de uma paciente com a radiografia de tórax abaixo".
-- Na prova original as alternativas A e B repetiam "Estenose mitral." (erro de edição). A B passa a ser "Insuficiência mitral.",
-- o gabarito continua A (estenose mitral) e os comentários são reescritos para explicar por que a insuficiência mitral não é a resposta.
-- Mexe só nesta questão (id abaixo). Só altera se a alternativa B ainda estiver como "Estenose mitral."; se já foi trocada, avisa e não faz nada.
-- Roda numa transação só: se algo não bater, nada é gravado. Rode no SQL Editor do Supabase.
begin;

do $$
declare
  v_id constant uuid := '65738bde-b293-4fea-9002-0b331f336e9e';
  v_b  text;
begin
  select o.texto into v_b from public.question_options o where o.question_id = v_id and upper(o.letra) = 'B';
  if v_b is null then
    raise exception 'Questão ou alternativa B não encontrada (id %). Nada foi alterado.', v_id;
  end if;
  if v_b = 'Insuficiência mitral.' then
    raise notice 'A alternativa B já está como "Insuficiência mitral."; nada a fazer.';
    return;
  end if;
  if v_b <> 'Estenose mitral.' then
    raise exception 'A alternativa B está como "%", e não como o esperado ("Estenose mitral."). Nada foi alterado.', v_b;
  end if;

  update public.question_options set texto = 'Insuficiência mitral.', correta = false
   where question_id = v_id and upper(letra) = 'B';

  update public.questions
     set comentario = $Q$Radiografia com aumento do átrio esquerdo e abaulamento do arco médio esquerdo (configuração mitral), com ventrículo esquerdo de tamanho normal, em paciente jovem, sugere estenose mitral e não insuficiência mitral — alternativa A.$Q$,
         comentario_completo = $Q$A radiografia de tórax em PA mostra área cardíaca de configuração mitral: retificação ou abaulamento do arco médio da borda cardíaca esquerda (tronco da artéria pulmonar e apêndice atrial esquerdo proeminentes) e sinais de aumento do átrio esquerdo, com campos pulmonares de aspecto congestivo, sem a cardiomegalia globular da doença de Chagas e sem alongamento do ventrículo esquerdo com aorta ectasiada da estenose aórtica.
Sinais radiográficos clássicos da estenose mitral:
• Aumento do átrio esquerdo: duplo contorno à direita da silhueta cardíaca, elevação do brônquio fonte esquerdo e sinal do 'quarto arco' à esquerda (apêndice atrial);
• Dilatação do tronco da artéria pulmonar (abaulamento do arco médio) por hipertensão pulmonar;
• Sinais de hipertensão venocapilar: redistribuição de fluxo para os ápices, linhas B de Kerley, congestão;
• Ventrículo esquerdo de tamanho normal (a estenose pura não o dilata) e, em fases avançadas, aumento do ventrículo direito.
Na doença reumática, em paciente do sexo feminino em idade jovem, esse é o diagnóstico mais provável — alternativa A.

Por que as outras alternativas estão incorretas:
• B) A insuficiência mitral crônica também aumenta o átrio esquerdo, mas o refluxo sobrecarrega o ventrículo esquerdo de volume e o dilata: a radiografia mostra aumento da área cardíaca à custa do ventrículo esquerdo (ponta arredondada, desviada para baixo e para a esquerda). Com o ventrículo esquerdo de tamanho normal e o arco médio abaulado, como aqui, o padrão é o da estenose mitral.
• C) A cardiopatia chagásica avançada tipicamente mostra cardiomegalia globular importante, com aumento de várias câmaras; não é o padrão de configuração mitral com átrio esquerdo proeminente e ventrículo esquerdo preservado.
• D) A estenose aórtica produz aumento do ventrículo esquerdo (ponta arredondada, sobrecarga concêntrica), dilatação pós-estenótica da aorta ascendente e calcificação valvar, sem o abaulamento do arco médio nem o duplo contorno atrial.
• E) A radiografia não é normal: há alteração da silhueta cardíaca com sinais de aumento atrial esquerdo.

Observação: na prova original, as alternativas A e B repetiam o texto "Estenose mitral" (erro de edição). Aqui a B foi trocada por "Insuficiência mitral", de modo que a questão tem uma única resposta correta.$Q$
   where id = v_id;
end
$$;

-- Conferência: A segue como a única correta e a B agora é "Insuficiência mitral."
select letra, texto, correta from public.question_options
 where question_id = '65738bde-b293-4fea-9002-0b331f336e9e' order by letra;

commit;

/datum/event/pda_spam
	endWhen = 6000
	var/last_spam_time = 0
	var/obj/machinery/message_server/useMS

/datum/event/pda_spam/setup()
	last_spam_time = world.time
	for (var/obj/machinery/message_server/MS in message_servers)
		if(MS.active)
			useMS = MS
			break

/datum/event/pda_spam/tick()
	if(world.time > last_spam_time + 1200)
		//if there's no server active for two minutes, give up
		kill()
		return

	if(!useMS || !useMS.active)
		useMS = null
		if(message_servers)
			for (var/obj/machinery/message_server/MS in message_servers)
				if(MS.active)
					useMS = MS
					break

	if(useMS)
		last_spam_time = world.time
		if(prob(2))
			// /obj/machinery/message_server/proc/send_pda_message(var/recipient = "",var/sender = "",var/message = "")
			var/obj/item/device/pda/P
			var/list/viables = list()
			for(var/obj/item/device/pda/check_pda in sortAtom(PDAs))
				if (!check_pda.owner||check_pda.toff||check_pda == src||check_pda.hidden)
					continue
				viables.Add(check_pda)

			if(!viables.len)
				return
			P = pick(viables)

			var/sender
			var/message
			switch(pick(1,2,3,4,5,6,7))
				if(1)
					sender = pick("MaxBet","MaxBet Online Casino","��� ������� ������� ��� �����������","� ���, ��� �� �������������� � ���")
					message = pick("������� �������� ���� ��� �� MaxBet Online, ����� �� �����������������, ����� ������ � ���.",\
					"�� ������ �������� 200% �������������� ����� � Max Bet Online, ����� ����������������� �������.",\
					"���� ������� �� MaxBet, �� ����� ������ �������� �������� ������������ � ����������� �����.",\
					"�� MaxBet �� ������� ����������� ����� ��� 450 �������������� ������ � ������.")
				if(2)
					sender = pick(300;"�����������������������",200;"����� ���� ������� �������",50;"���������� ��������� ����",50;"����� ���� ������ ������������ � ��������",50;"�������� ������� ��������")
					message = pick("��� ������� ������� ��� ��������, � � ����� �������� � ������������� (������� ����������).",\
					"���� �� �������� ��� �� ����� [pick(first_names_female)]@[pick(last_names)].[pick("ru","ck","tj","ur","nt")] � ����������� ������ ��� ���� (������� ����������).",\
					"� ����, ����� �� ������ ���� ����� � �������, ��� ���� ���������� ��� ������� � �� ��� ���������� (������� ����������).",\
					"� ��� ���� ����� ���������!",\
					"� ��� ��� ����� ��������� �������!")
				if(3)
					sender = pick("������������� ��������� ����������","������ ������-����","��� ���� E-Payments","���������� ����������� �����������","����� ����")
					message = pick("������� ���� ��������� �� ��������� ����!",\
					"����, ��������� ������� � ����������, ����� � ��������!",\
					"������� 100 �������� � �������� �� 300% ������ ���������� ���������!",\
					"���������� �� ������ 100K.NT/WOWGOLD � �������� ������� ����������� 1000 �������� ���������� ���������",\
					"�� �������� ������ �� ������ �� ����� �������� �� ��� ������� ��������� � ����.",\
					"����������� ������ ��� ������� ����� � ������ (�����������), ����� �������� �� ��� ������.")
				if(4)
					sender = pick("����������� ������� ��������","������ ����������������� ��������?")
					message = pick("������ �������: ��������� �������, ��������� �����, ��������� ����������!",\
					"������ ������� ��� ������ �������� ���������, �������� ����������� ����, ����������������� �������� CentComm, ������� ������� ����� 70 000 ��������� �� ����� ������� � '�������� ����������'.",\
					"����� ���� ��� ������������ ������ ������� � ��� ������� ��������� ��� ������� ������������� ������� ��������� ������� �������...",\
					"������� ���� ����� �������� �� ������������ ���������� �����, ������ � ������������.")
				if(5)
					sender = pick("������","���������","������-������","���������","�������")
					sender += " " + pick("������","�������","��������","�������","����","�����")
					sender += " " + pick("������", "����", "���������", "��������", "����", "�������")
					message = pick("��� ���� ��� ��������� � [pick("Salusa","Segunda","Cepheus","Andromeda","Gruis","Corona","Aquila","ARES","Asellus")] ���� �������� ��� ���������� ��������� �������.",\
					"�� ���� �������� ���, ��� � ����� � ���������, ��� ���� �������� ��������������� ������ ��� �������� �� ��� ����.",\
					"��������� ���������� �������, ������ ��� ��������, ��� ������������ ������� ������� ���� ������������ ���������� � �������� � ������.",\
					"� ����� � ����������� � ���� ������� � ������, ����� �� ����������� ���������� ����� ���� ���������� ������� ����� � ������� 1 ������� ��������.",\
					"����������� ���, ���, � ���������� �������, ���, ������ ����� ��-�� ���������� �����������, � ������ ���, ����� �������� ������ ����� ���� ����������� ���������� � ������� 1,5 ��������� ��������.")
				if(6)
					sender = pick("������������� ���������� ���� �����������","���������� ���� �������?","������?","www.wetskrell.nt")
					message = pick("������������� ���������� ���� ����������� ����� ������������ ��� ������������ ��������������� �����.",\
					"WetSkrell.nt - ��� ���������������� ���-����, ���������� �� ��� ������������� ������� ������� �������� ���� ����� ��������� ������� � ����������.",\
					"Wetskrell.nt ������������� ������ ����� ������� �������� ������� ����������� ��� ����������� �����������",\
					"������ ������� ��������� ����� � PIN-��� ������ ����� � ����� �����������. ������ ��� ������� ����, ��������������� ������ WetSkrell.nt ������ ������!")
				if(7)
					sender = pick("�� �������� ���������� ������!", "������� ����, ����� ������� ���� ����!", "�� - 1000-� ����������!", "�� - ���������� ���������� ������ �������� �����!")
					message = pick("�� �������� ������ �� �������� ����� �������� ��������!",\
					"�� �������� ������ �� �������� ������������ ����� ����������� ������� � �������� ���������!",\
					"�� �������� ������ �� �������� ������������� ������� 16 ������ �����!",\
					"�� �������� ������ �� �������� ������� ����� �������!")

			useMS.send_pda_message("[P.owner]", sender, message)

			if (prob(50)) //Give the AI an increased chance to intercept the message
				for(var/mob/living/silicon/ai/ai in ai_list)
					// Allows other AIs to intercept the message but the AI won't intercept their own message.
					if(ai.pda != P && ai.pda != src)
						to_chat(ai, "<i>������������� ��������� �� <b>[sender]</b></i> (���������� / ����?) <i>to <b>[P:owner]</b>: [message]</i>")

			//Commented out because we don't send messages like this anymore.  Instead it will just popup in their chat window.
			//P.tnote += "<i><b>&larr; From [sender] (Unknown / spam?):</b></i><br>[message]<br>"

			if (!P.message_silent)
				playsound(P, 'sound/machines/twobeep.ogg', VOL_EFFECTS_MASTER)
			if(!P.message_silent)
				P.audible_message("[bicon(P)] *[P.ttone]*", hearing_distance = 3)
			//Search for holder of the PDA.
			var/mob/living/L = null
			if(P.loc && isliving(P.loc))
				L = P.loc
			//Maybe they are a pAI!
			else
				L = get(P, /mob/living/silicon)

			if(L)
				to_chat(L, "[bicon(P)] <b>��������� �� [sender] (���������� / ����?), </b>\"[message]\" (���������� ��������)")

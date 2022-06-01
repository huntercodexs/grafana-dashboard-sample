#!/bin/bash

touch db-purchases-insert.sql
echo 'TRUNCATE purchases;' > db-purchases-insert.sql

for ((i = 1; i < 1001; i++)); do
	
	COUNTER=$(printf "%04d" ${i})
	QUANTITY=$(expr ${i} / 200 \* 2)
	PRICE="R$ 100.00"
	DELETED=NULL
	ORIGIN=app

	DATE1="2021-01-10 10:44:07"
	DATE2="2021-04-10 02:44:07"
	DATE3="2021-08-10 01:44:07"
	DATE4="2021-02-10 12:44:07"
	DATE5="2021-06-10 13:44:07"
	DATE6="2021-11-10 16:44:07"
	DATE7="2021-09-10 01:44:07"
	DATE8="2021-10-10 09:44:07"
	DATE9="2021-02-10 06:44:07"

	DATE10="2022-02-10 09:44:07"
	DATE11="2022-04-10 22:44:07"
	DATE12="2022-05-10 12:44:07"
	DATE13="2022-02-10 15:44:07"
	DATE14="2022-03-10 13:44:07"
	DATE15="2022-01-10 17:44:07"
	DATE16="2022-04-10 18:44:07"
	DATE17="2022-02-10 20:44:07"
	DATE18="2022-05-10 15:44:07"

	if [[ ${i} < 10 ]]; then
		DATE=${DATE1}
		PRICE="R$ 100.00"
	elif [[ ${i} < 50 ]]; then
		DATE=${DATE2}
		PRICE="R$ 170.00"
		ORIGIN=website
	elif [[ ${i} < 100 ]]; then
		DATE=${DATE3}
		PRICE="R$ 77.00"
		DELETED="'${DATE3}'"
	elif [[ ${i} < 150 ]]; then
		DATE=${DATE2}
		PRICE="R$ 100.00"
	elif [[ ${i} < 200 ]]; then
		DATE=${DATE4}
		PRICE="R$ 3400.00"
	elif [[ ${i} < 250 ]]; then
		DATE=${DATE5}
		PRICE="R$ 120.00"
	elif [[ ${i} < 300 ]]; then
		DATE=${DATE6}
		PRICE="R$ 100.00"
		ORIGIN=website
	elif [[ ${i} < 320 ]]; then
		# Nenhuma compra feita pelos usuarios com esse ID
		continue;
	elif [[ ${i} < 350 ]]; then
		DATE=${DATE7}
		PRICE="R$ 140.00"
	elif [[ ${i} < 400 ]]; then
		DATE=${DATE8}
		PRICE="R$ 100.00"
	elif [[ ${i} < 450 ]]; then
		DATE=${DATE9}
		PRICE="R$ 10.00"
	elif [[ ${i} < 500 ]]; then
		DATE=${DATE10}
		PRICE="R$ 160.00"
		DELETED="'${DATE10}'"
	elif [[ ${i} < 550 ]]; then
		DATE=${DATE11}
		PRICE="R$ 100.00"
		ORIGIN=website
	elif [[ ${i} < 600 ]]; then
		DATE=${DATE12}
		PRICE="R$ 100.00"
	elif [[ ${i} < 650 ]]; then
		DATE=${DATE13}
		PRICE="R$ 1530.00"
	elif [[ ${i} < 720 ]]; then
		# Nenhuma compra feita pelos usuarios com esse ID
		continue;
	elif [[ ${i} < 700 ]]; then
		DATE=${DATE14}
		PRICE="R$ 130.00"
	elif [[ ${i} < 750 ]]; then
		DATE=${DATE15}
		PRICE="R$ 100.00"
		ORIGIN=website
	elif [[ ${i} < 800 ]]; then
		DATE=${DATE16}
		PRICE="R$ 30.00"
		DELETED="'${DATE16}'"
		ORIGIN=website
	elif [[ ${i} < 850 ]]; then
		DATE=${DATE17}
		PRICE="R$ 200.00"
	elif [[ ${i} < 900 ]]; then
		DATE=${DATE18}
		PRICE="R$ 100.00"
	else
		DATE=$(date '+%Y-%m-%d %H:%M:%S')
		PRICE="R$ 650.00"
	fi

	if [[ ${QUANTITY} < 1 ]]; then
		QUANTITY=1
	fi

	echo "INSERT INTO purchases(user_id, product, price, quantity, category, origin, createdAt, updatedAt, deletedAt)
	VALUES(${i}, 'Product ${COUNTER}', '${PRICE}', '${QUANTITY}', 'Category ${COUNTER}', '${ORIGIN}', '${DATE}', NULL, ${DELETED});" >> db-purchases-insert.sql
	echo "" >> db-purchases-insert.sql

done

exit 0

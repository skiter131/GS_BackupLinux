#!/bin/bash
#
#################################################################################
#  Comentarios do Script: Esse script tem como objetivo realizar o backup da  
#  infraestrutura dos servidores Web, Arquivos e  Internet
#################################################################################
#
#                  Nome: Backup.sh
#
#################################################################################

SERVER="$1"
NOME_BKP="bkp_$SERVER _$(date +%d%m%y).tar.gz"
BKP_ANT="bkp_$SERVER _$(date +%d%m%y --date="-7 days").tar.gz"
VALIDA_BKP="Erro ao gerar validação do backup"
VALIDA_OLD="Erro ao gerar validação da exclusão do backup antigo"

function validacao {
    if [ -e "${DIR_BKP}${NOME_BKP}" ] ; then
        VALIDA_BKP="Backup realizado com exito"
        echo "$(date)----- $VALIDA_BKP"
    else
        VALIDA_BKP="Falha ao gerar arquivo de backup"
        echo "$(date)----- $VALIDA_BKP"
    fi

    if [ ! -e "${DIR_BKP}${BKP_ANT}" ] ; then
        VALIDA_OLD="Excluido arquivo de backup com mais de 7 dias"
        echo "$(date)----- $VALIDA_OLD"
    else
        VALIDA_OLD="Falha ao excluir arquivo de backup com mais de 7 dias"
        echo "$(date)----- $VALIDA_OLD"
    fi
}

if [ -e "${DIR_BKP}${NOME_BKP}" ] ; then
    echo "Arquivo duplicado"
    validacao
else
    if [ -e "${DIR_BKP}${BKP_ANT}" ] ; then
        rm -rf ${DIR_BKP}${BKP_ANT}
    fi
    tar -cvzf ${DIR_BKP}${NOME_BKP} ${DIR_SAMBA}
    validacao
fi 

echo "*********************************************************************************"
echo "*"
echo "*                  Execução do programa finalizada"
echo "*"
echo "*  ${VALIDA_BKP}"
echo "*"
echo "*  ${VALIDA_OLD}"
echo "*"
echo "*"
echo "*********************************************************************************"

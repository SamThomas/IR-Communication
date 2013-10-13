; -----------------------------
; -- Fichier principal du PT --
; -----------------------------
; -- Manon commun            --
; -- Samuel Thomas           --
; -- Alexandre Brand         --
; -- Loïc Dalloz             --
; -----------------------------
; -- Version 1.0             --
; -----------------------------

; -----------------------------
; -- Configuration           --
; -----------------------------
list P=16F877A
#include <P16F877A.INC>
__CONFIG _HS_OSC & _WDT_OFF & _CP_OFF & _CPD_OFF & _LVP_OFF

; -----------------------------
; -- Amorçage                --
; -----------------------------
    org     0x0000
    goto    start

    org     0x0004
    goto    irq_handle

; -------------------------------
; -- Démarrage du programme    --
; -- et initialisation         --
; -------------------------------
start:
    ; -- PortC en entrée
    bsf     STATUS, RP0 ; -- bank 1
    clrf    TRISC
    bcf     STATUS, RP0 ; -- bank 0
    clrf    PORTC

    ; -- gestion de la réception (à préciser)
    movlw b'11110011'
    movwf RCSTA
    movlw b'10010000'
    movwf TXSTA

    ; -- Timer (?)

    ; -- gestion des interruptions sur le port série activé
    bsf     INTCON, GIE
    bcf     PIR1, RC1F
    bsf     STATUS, RP0 ; -- bank 1
    bsf     PIE1, PC1E
    bcf     STATUS, RP0 ; -- bank 0

; -------------------------------
; -- Boucle infinie            --
; -------------------------------
main:
    goto    main

; -------------------------------
; -- Gestion des interruptions --
; -------------------------------
irq_handle:
    btfsc   PIR1, RC1F ; -- test de l'interruption de réception
    goto    interruption_reception
    retfie

; -------------------------------
; -- Interruption réception    --
; -------------------------------
interruption_reception:
    ; -- lecture de l'octet reçue dans le registre RCREG
    retfie

; -------------------------------
; -- Fin du prog               --
; -------------------------------
    end

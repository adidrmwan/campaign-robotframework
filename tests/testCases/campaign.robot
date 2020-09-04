*** Settings ***
Resource                  ../keywords/keywordsCampaign.robot

Suite Setup             Open The Browser
Suite Teardown          Close Browser

*** Test Case ***
Make_A_Donation_In_Campaign
    Choose Campaign
    Validate Campaign Page
    Click Donasi Sekarang Button
    Validate Nominal Page
    Select Amount as Rp 10.000
    Validate Metode Pembayaran Page
    Select Payment Method BCA
    Validate Payment Detail Page
    Input Required Field
    CLick Lanjutkan Pembayaran Button
    Close Banner Pop Up
    Validate Payment Instruction Page
    Click Kembali ke Penggalangan Button
    Click Back Button on Campaign


    

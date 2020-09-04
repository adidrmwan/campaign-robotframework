*** Settings ***
Library     Selenium2Library
Library     String
Variables   ../data/env.py      

*** Variable ***
${campaign}=                        xpath://*[@id="template_horizontal-wide-card-slider"]/div/div/a[1]/div/div

#Campaign Page
${donasi_sekarang_btn}=             id:campaign-detail_button_donasi-sekarang
${campaign_banner}=                 xpath://*[@id="campaign-page"]/div[2]
${back_to_home_btn}=                xpath://*[@id="plain-header"]
${campaign_title}=                  id:campaign-info__title
${donation_received_info}=          id:campaign-info__donation-received
${raiser_img}=                      xpath://*[@id="campaign-page"]/div[5]/div[2]/div[2]/div[1]
${raiser_title}=                    xpath://*[@id="campaign-page"]/div[5]/div[2]/div[2]/div[2]/div

#Nominal Page
${amount_select}=                   xpath://body/div[@id='__next']/main[@id='donation-amount']/div[2]
${nominal_banner}=                  xpath://*[@id="donation-amount"]/div[1]

#Metode Pembayaran Page
${bca_payment}=                     xpath://*[@id="__next"]/main/div[6]/div[5]

#Payment Detail Page
${name_field}=                      name:fullname
${email_field}=                     name:username
${payment_type_info}=               id:contribute_itemlist_list-pembayaran-19
${anonim_field}=                    id:donasi-anonim
${support_field}=                   id:contribute_textarea_dukungan
${next_payment_btn}=                id:contribute_button_lanjutkan-pembayaran
${amount_detail_field}=             id:contribute_inputfield_amount-donation

#Payment Instruction Page
${banner}=                          xpath://*[@id="summary-page"]/div[8]
${close_banner_btn}=                xpath://*[@id="summary-page"]/div[8]/a[1]/span
${back_to_campaign_btn}=            xpath://*[@id="summary-page"]/div[6]/div[3]/button
${nominal_transfer}=                xpath://*[@id="summary-page"]/div[2]/div/div[1]/h2
${donation_amount}=                 xpath://*[@id="summary-page"]/div[2]/div/div[3]/div[1]/span[2]
${unique_amount}=                   xpath://*[@id="summary-page"]/div[2]/div/div[3]/div[2]/span[2]
${bank_transfer_info}=              xpath://*[@id="summary-page"]/div[4]/div[1]

#Value for field
${name_value}=                      Adi Darmawan
${email_value}=                     adi.darmawan@gmail.com


*** Keywords ***
Open The Browser
    Open Browser            ${url}          ${browser}
    Maximize Browser Window

Choose Campaign
    Sleep           3s
    Execute JavaScript    window.scrollTo(0,Math.max(document.documentElement.scrollHeight, document.body.scrollHeight, document.documentElement.clientHeight))
    Sleep           3s
    Click Element           ${campaign}
    Sleep           3s

Click Donasi Sekarang Button
    Click Element           ${donasi_sekarang_btn}
    Sleep           3s

Select Amount as Rp 10.000
    Click Element           ${amount_select}
    Sleep           3s

Select Payment Method BCA
    Click Element           ${bca_payment}
    Sleep           3s

Input Required Field
    Input Text          ${name_field}           ${name_value}  
    Input Text          ${email_field}          ${email_value}
    Sleep       3s    

CLick Lanjutkan Pembayaran Button
    Click Element           ${next_payment_btn}
    Sleep       3s

Close Banner Pop Up
    Click Element           ${close_banner_btn}
    Sleep       3s

Click Kembali ke Penggalangan Button
    Click Element           ${back_to_campaign_btn}
    Sleep           3s

Click Back Button on Campaign
    Click Element           ${back_to_home_btn}
    Sleep           3s

Validate Campaign Page
    Page Should Contain Element             ${donasi_sekarang_btn}
    Page Should Contain Element             ${campaign_banner}
    Page Should Contain Element             ${back_to_home_btn}
    Page Should Contain Element             ${donation_received_info}
    Page Should Contain Element             ${campaign_title}
    Page Should Contain Element             ${raiser_img}
    Page Should Contain Element             ${raiser_title}

Validate Nominal Page
    Page Should Contain Element             ${next_payment_btn}
    Page Should Contain Element             ${nominal_banner}
    Page Should Contain                     Masukan Nominal Donasi

Validate Metode Pembayaran Page
    ${instant_payment}=         Get Text            xpath=//*[@id="__next"]/main/div[1]/label
    ${virtual_account}=         Get Text            xpath=//*[@id="__next"]/main/div[3]/label
    Execute JavaScript    window.scrollTo(0,Math.max(document.documentElement.scrollHeight, document.body.scrollHeight, document.documentElement.clientHeight))
    Sleep       2s
    ${transfer_payment}=        Get Text            xpath=//*[@id="__next"]/main/div[5]/label
    ${credit_card}=             Get Text            xpath=//*[@id="__next"]/main/div[7]/label
    Should Be Equal         ${instant_payment}                  Pembayaran Instan (Cepat & Mudah)   
    Should Be Equal         ${virtual_account}                  Virtual Account (Verifikasi Otomatis)
    Should Be Equal         ${transfer_payment}                 Transfer Bank (Verifikasi Manual 1x24jam)
    Should Be Equal         ${credit_card}                      Kartu Kredit

Validate Payment Detail Page
    Page Should Contain Element             ${name_field}
    Page Should Contain Element             ${email_field}
    Page Should Contain Element             ${payment_type_info}
    Page Should Contain Element             ${anonim_field}
    Page Should Contain Element             ${support_field}
    Page Should Contain Element             ${next_payment_btn}
    Page Should Contain Element             ${amount_detail_field}
    Sleep       2s
    ${amount_detail}=           Get Value           ${amount_detail_field}
    Set Global Variable         ${amount_detail}
    Should Be Equal         ${amount_detail}                10.000

Validate Payment Instruction Page
    Page Should Contain                     Instruksi Pembayaran
    Page Should Contain Element             ${back_to_campaign_btn}
    Page Should Contain Element             ${nominal_transfer}
    Page Should Contain Element             ${donation_amount}
    Page Should Contain Element             ${unique_amount}
    Page Should Contain Element             ${bank_transfer_info}
    Sleep       2s
    
    ${unique}=              Get Text                ${unique_amount}
    ${unique_value}=        Convert To Integer      ${unique}
    
    ${donation_temp}=           Get Text            ${donation_amount}
    ${donation}=            Remove String           ${donation_temp}        Rp      .       ${SPACE}
    ${donation}=            Convert To Integer      ${donation}
    ${donation_value}=            Evaluate                ${donation} - ${unique_value}

    ${amount}=              Remove String           ${amount_detail}        .
    ${amount}=              Convert To Integer      ${amount}

    Should Be Equal As Integers         ${donation_value}             ${amount}       


import 'package:aurask/meta/Utility/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          "Terms & Conditions",
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            box10,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "These Terms of Service (the “ToS”) applies with respect to the usage of the Platform (defined hereinafter) and the services offered by Aurask Software Services Private Limited and Aurask Technologies Pvt Ltd (“Aurask”, “Aurask”, “we”, or “us”), a Limited Liability Partnership formed and incorporated under the Limited Liability Partnership Act, 2008 and having its registered office at EB - 02 B, Chamber Offices, Common Utility, Town Center, Amanora, Pune – 411028. Aurask conducts its business under the brand titled “Aurask”, which is owned and operated by Aurask. In these ToS, the term “Aurask” shall mean Aurask. These Terms of Service shall mutatis mutandis apply to mobile apps, WhatsApp groups, Facebook groups, Instagram pages, Facebook pages, email/SMS/phone communications and other communication forums/media hosted by Aurask, which shall be deemed to be part of the Platform (defined hereinafter). Your usage of the Aurask Services (defined hereinafter) is subject to your explicit acceptance of these ToS. The terms contained in our privacy policy available at (“PrivacyPolicy”), or any other policy of Aurask related to the Aurask Services are incorporated into these ToS by this reference. Your acceptance of the same will irrevocably and unconditionally bind you to comply with and abide by all the obligations and conditions stipulated herein (unless otherwise explicitly made optional). After your initial confirmation/consent, you will be assumed to continue consenting to these ToS until you explicitly withdraw your consent by notifying Aurask of the same in writing. If an executed agreement exists between You and Aurask in relation to the Aurask Services, any deviations from these ToS shall only apply when explicitly agreed in writing between the parties to such an agreement. IF YOU DO NOT AGREE TO BE BOUND BY ALL CONDITIONS/CLAUSES CAPTURED IN THESE TOS, PLEASE DO NOT USE THE PLATFORM OR SERVICES.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, fontSize: 13),
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: tnc.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tnc[index]["title"],
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        box5,
                        Text(
                          tnc[index]["subtitle"],
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                        if (tnc[index]["points"].length != 0)
                          ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              itemCount: tnc[index]["points"].length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int i) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${(i + 1).toString()} .  ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Expanded(
                                          child: Text(
                                        tnc[index]["points"][i],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black87),
                                      ))
                                    ],
                                  ),
                                );
                              }),
                        box5,
                        Text(
                          tnc[index]["bottom"],
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 30,
                        )
                      ]);
                }),
            Divider(),
          ])),
    );
  }

  static const List tnc = [
    {
      "title": "Updation of Terms",
      "subtitle":
          "These ToS may be updated, amended, modified or revised by usfrom time to time. Each such updation or modification to the ToS will be communicated to you via email, through the Website or any other medium. Your continued use of the Aurask Services after any such changes shall constitute your consent to such changes. We encourage you to refer to these ToS from time to time to ensure that you are aware of any additions, revisions, amendments or modifications that we may have made.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Service(s) provided to Users",
      "subtitle":
          "Aurask allows its users to access various training programs on computer sciences designed by Aurask for undergraduates and professionals, including Aurask Edge, Aurask Academy, Aurask Plus or any other program or application that Aurask introduces from time to time (hereinafter collectively referred to as “Service(s)” or “Aurask Service(s)” and each of these training programs shall be referred to as a “Program” and collectively as “Programs”). Aurask reserves the right, in its sole discretion, to add, change, suspend, or discontinue all or any part of the Aurask Services at any time. Your continued use of Aurask Services following the posting of any changes to the same (including the addition or removal of features) constitutes your acceptance of those changes. Any information you provide to us for the purposes of registering and setting up your account (as specified below) shall be considered as accurate, complete and updated. You are solely responsible for the activity that occurs on your account (including those of others authorised to access and operate your account) and for maintaining the security of your account and any information you input. We are not responsible for the accuracy or legitimacy of any information, data, or User Data uploaded or posted on the Platform. For the purposes of clarity, as long as your account is accessed with the correct login credentials and unless you notify us of any unauthorised access, you shall be solely responsible for all actions/defaults related to your account.",
      "points": [],
      "bottom":
          "In consideration of your acceptance of these ToS and if applicable, any subscription agreement (or any other similar agreement) executed between you and Aurask, Aurask grants the User a personal, non-exclusive, non-transferable, non-sublicensable, revocable limited license to access and use the Platform and Services, in accordance with the ToS."
    },
    {
      "title": "Registration and Account Integrity",
      "subtitle":
          "As part of the registration process, you will need to accept our ToS, and also provide us with your name, your phone number, your email ID and in certain scenarios, contact information of your parents/guardian. We would not at any time request you to provide us with access to your password, unless you have given us explicit written permission to access your account pursuant to a request for assistance or support.\nIt is your responsibility to ensure that the information you provide is accurate, secure, and not misleading. You cannot create an account username and password using (i) the names and information of another person; or (ii) using words that are the trademarks or the property of another party (including ours); or (iii) words that are vulgar, obscene or in any other way inappropriate. You agree and confirm that you will never use another User’s account nor provide access to your account to any third-party. You agree and acknowledge that you are solely responsible for the activities that occur on your account, and you shall keep your account password secure and not share the same with anyone. You must notify Aurask immediately of any breach of security or unauthorized use of your account. At no point in time will Aurask be liable for any losses caused by any unauthorized use of your account, and you shall solely be liable for the losses caused to Aurask or others due to such unauthorized use, if any.",
      "points": [],
      "bottom":
          "You shall be solely responsible for obtaining and maintaining any equipment or ancillary services necessary to connect to, access, receive the Aurask Services or use the Platform, including, without limitation, hardware devices, software, and other internet, wireless, broadband, phone or other mobile communication device connection services. You shall be solely responsible for ensuring that such equipment or ancillary services are compatible with the Platform, and you shall be responsible for all charges incurred in connection with the use of the Platform or Aurask Services in connection with all such equipment and ancillary services."
    },
    {
      "title": "Use of your Information and User Data",
      "subtitle":
          "All User Data that you create, transmit, transfer to us, submit, display or otherwise make available while using the Aurask Services, should only be information that you own or have the right to use or share (as may be applicable). If you transfer any personally identifiable information to us, we will assume that you have informed the person concerned and procured the necessary consent for such transfer, sharing, processing and/or using the information on the Platform and/or in respect of the Services. We may use the above information as per our Privacy Policy and in accordance with applicable laws.",
      "points": [],
      "bottom":
          "While we make commercially reasonable efforts to ensure that the data stored on our servers is persistent and always available to our Users, we will not be responsible in the event of failure of the third-party servers or any other factors outside our reasonable control, that may cause the User Data to be permanently deleted, irretrievable, or temporarily inaccessible."
    },
    {
      "title": "Third Party Links and Services",
      "subtitle":
          "We use multiple third-party service providers in order to power and provide you with the Aurask Services. In this process, we share the User Data with some of the third-party service providers, as is necessary to enable them to provide the requisite services. We will attempt to ensure that all our third-party service providers are bound by and adhere to the same obligations of confidentiality and data privacy as we guarantee to you. The Platform may include links to any third-party websites. Aurask has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third-party website. By using the Platform, you expressly release Aurask from any liability arising from your use of any third-party website or services.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Rules and Acceptable Usage Policy",
      "subtitle":
          "As a condition of use, you promise not to use the Aurask Services for any purpose that is prohibited by these ToS, by law, or other rules or policies implemented by us from time to time. The Aurask Services and Aurask Content is provided only for your own personal, non-commercial use. You agree to notify us immediately in case you observe any other User breaching the terms contained herein or any policy associated with the Programs.\n\nWhile using the Platform, you shall not:",
      "points": [
        "harass any third party including any Users or Customers",
        "create an atmosphere of disharmony, hostility within student groups",
        "use unethical methods during any assignment, test/exam conducted on the Platform or otherwise in relation to any Program",
        "share any Aurask Content (including any study materials or test materials) with anybody through any media",
        "share solutions to assignments/test materials pertaining to the Platform."
      ],
      "bottom":
          "Furthermore, you shall not (directly or indirectly): (i) take any action that imposes or may impose an unreasonable or disproportionately large load on Aurask’s (or its third party providers’) infrastructure; (ii) interfere or attempt to interfere with the proper working of the Platform; (iii) bypass any measures we may use to prevent or restrict access to the Aurask Services (or parts thereof); (iv) modify, translate, or otherwise create derivative works of any part of the Aurask Services or the Platform; or (v) copy, rent, download, extract, lease, distribute, or transfer any part of the Platform, Aurask Content or any third party User Data, unless Aurask specifically allows you to do so."
    },
    {
      "title": "Content Ownership and Copyright Conditions of Access",
      "subtitle":
          "The Platform and the Aurask Content, including but not limited to all text, graphics, user interfaces, visual interfaces, sounds, artwork and computer code are owned and controlled by Aurask and/or its licensors and the design, structure, selection, expression and arrangement of such content mentioned hereinabove is protected by copyright, patent and trademark laws, and other applicable laws on intellectual property rights. We reserve all rights, title, and ownership in and to the Platform and Aurask Content.\nAurask’s logos, trademarks and service marks that may appear on the Platform, including but not limited to “Aurask”, “Aurask Aurask”, “Aurask Edge”, “Aurask Academy” and “Aurask Plus” (collectively, “Aurask Marks”) are the property of Aurask and are protected under applicable laws on intellectual property rights.\nYour copying, distributing, displaying, reproducing, modifying, or in any other way using of the Aurask Content in any manner not specified in these ToS, will be a violation of copyright and other intellectual property rights and Aurask reserves its rights under applicable law accordingly.",
      "points": [],
      "bottom":
          "You shall, at all times, remain the complete owner and retain all rights and title in and to the User Data. This includes assuming liability and responsibility in cases where the User Data breaches any conditions of confidentiality, any intellectual property rights, or any other third-party rights. By posting any User Data through the Aurask Services, you grant Aurask and its affiliates, a worldwide, non-exclusive, royalty-free, irrevocable, sub-licensable and transferable license to use, copy, reformat, modify, translate, display, sell, create derivative works and distribute such User Data for or in connection with the use of the Aurask Services."
    },
    {
      "title": "Reviews and Feedback",
      "subtitle":
          "You agree that we may contact you through telephone, email, SMS, or any other electronic means of communication for the purpose of:",
      "points": [
        "Obtaining feedback in relation to the Platform or Aurask Services; and/or",
        "Resolving any complaints, information, or queries received from you regarding the same."
      ],
      "bottom":
          "Any feedback provided by you may be used by Aurask without any restriction or obligation to compensate you, and we are under no obligation to keep such feedback confidential."
    },
    {
      "title": "Rights and Obligations relating to the Content",
      "subtitle": "You are prohibited from:",
      "points": [
        "violating or attempting to violate the integrity or security of the Platform or any content therein;",
        "transmitting any information (including messages and hyperlinks) on or through the Platform that is disruptive or competitive to the provision of our Services",
        "distributing in any medium, any part of the Platform or the Aurask Content without Aurask’s prior written authorisation",
        "reproducing, duplicating, copying, selling, reselling or exploiting for any commercial purpose any Aurask Content or any portion thereof, other than as expressly allowed under this ToS",
        "using the Aurask Marks in connection with, or to transmit, any unsolicited communications or emails or for any other unauthorised purpose",
        "intentionally submitting on the Platform any incomplete, false or inaccurate information",
        "using any engine, software, tool, agent or other device or mechanism (such as spiders, robots etc.) to navigate or search the Platform",
        "attempting to decipher, decompile, disassemble, alter, modify or reverse engineer any part of the Platform",
        "copying or duplicating in any manner any of the Aurask Content or other information available from the Platform",
        "posting or transmitting, or cause to be posted or transmitted, any communication or solicitation or other “phishing”, “pharming” or “whaling” message designed or intended to obtain password, account, personal information, or confidential information from any other User or any other third party whatsoever",
        "using or launching any automated system, including without limitation, “robots,” “spiders,” or “offline readers,” that accesses the Platform in a manner that sends more request messages to Aurask’s servers in a given period of time than a human can reasonably produce in the same period by using a conventional on-line web browser",
        "circumventing or disabling any digital rights management, usage rules, or other security features of the Platform",
        "allowing any third party to access the Platform through your account unless Aurask specifically allows you to do so."
      ],
      "bottom":
          "You understand that while using the Platform, you may be exposed to User Data pertaining to other Users, and that Aurask is not responsible for such User Data. You further understand and acknowledge that you may be exposed to User Data that is inaccurate, offensive, indecent, or objectionable, and you agree to waive, and hereby do waive, any legal or equitable rights or remedies you have or may have against Aurask in relation thereto.\n\nAurask shall, upon obtaining knowledge by itself or been brought to actual knowledge in writing or through email about any breach of the above conditions, may temporarily suspend/delete your account, impose penalties, or take any other actions that Aurask may deem fit. We shall also be entitled to preserve such information and produce such records before governmental and/or judicial and/or regulatory authorities for investigation purposes as may be required by applicable law.\n\nIn your use of the Platform, you will at all times comply with all applicable laws and regulations. In case of non-compliance with any applicable laws, rules or regulations, or this ToS by a User, we shall have the right to immediately terminate your access or usage rights to the Platform and to remove non-compliant User Data from the Platform. Aurask shall not be liable to refund any fees/consideration collected from a Customer in case such Customer’s access to the Platform is terminated by Aurask for any reason detailed herein.\n\nIn the course of your usage of the Aurask Services, you may post reviews, comments, suggestions, ideas, questions and other content, or send any other communications as long as the content is not illegal, obscene, threatening, defamatory, invasive of privacy, infringing any third party’s intellectual property rights, or otherwise injurious to third parties or objectionable and does not consist of or contain software viruses, political campaigning, commercial solicitation, chain letters, mass mailings or any other form of spam. Further, you hereby grant Aurask a limited, royalty-free, worldwide, non-exclusive license to use the User Data (including the contents specified herein) in further developing the Platform and for the purpose of its marketing or promotional activities."
    },
    {
      "title": "Support",
      "subtitle":
          "Aurask offers online support tools. You may access support resources or contact our support team by emailing us at hello@Aurask.com. Aurask shall use commercially reasonable efforts to respond to your request for support, or to fix any problems you may be having, as is applicable. Any suggestions by Aurask to you regarding use of the Platform shall not be construed as a warranty.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Termination",
      "subtitle":
          "Aurask reserves the right to suspend or terminate your access to the Platform and the services with or without notice and to exercise any other remedy available under law, in cases where:",
      "points": [
        "you are in breach of any terms and conditions of this ToS",
        "Aurask is unable to verify or authenticate any information provided to Aurask by you; or",
        "Aurask has reasonable grounds for suspecting any illegal, fraudulent or abusive activity on your part."
      ],
      "bottom":
          "Once temporarily suspended, indefinitely suspended or terminated, you may not continue to use the Platform under the same account, a different account or re-register under a new account. Aurask may destroy and/or delete all the data and other information related to your account as per its discretion. All provisions of the ToS, which by their nature should survive termination, shall survive termination, including without limitation, warranty disclaimers, indemnity and limitations of liability."
    },
    {
      "title": "Disclaimer",
      "subtitle":
          "THE Aurask SERVICES AND THE Aurask CONTENT ARE PROVIDED ON AN “AS IS” AND “AS AVAILABLE” BASIS AND ARE WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, AND ANY WARRANTIES IMPLIED BY ANY COURSE OF PERFORMANCE OR USAGE OF TRADE, ALL OF WHICH ARE EXPRESSLY DISCLAIMED. Aurask AND ITS DIRECTORS, EMPLOYEES, AGENTS, SUPPLIERS, SPONSORS AND PARTNERS DO NOT WARRANT THAT: (A) THE Aurask SERVICES AND THE PLATFORM WILL BE SECURE, ERROR-FREE OR AVAILABLE AT ANY PARTICULAR TIME OR LOCATION; (B) ANY DEFECTS OR ERRORS WILL BE CORRECTED; (C) ANY CONTENT OR SOFTWARE AVAILABLE AT OR THROUGH THE PLATFORM IS FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS; OR (D) THE RESULTS OF USING THE PLATFORM WILL MEET YOUR REQUIREMENTS. THE Aurask SERVICES MAY BE SUBJECT TO LIMITATIONS, DELAYS, AND OTHER PROBLEMS INHERENT IN THE USE OF THE INTERNET AND ELECTRONIC COMMUNICATIONS. Aurask IS NOT RESPONSIBLE FOR ANY DELAYS, DELIVERY FAILURES, OR OTHER DAMAGE RESULTING FROM SUCH PROBLEMS. YOUR USE OF THE PLATFORM AND THE Aurask SERVICES IS SOLELY AT YOUR OWN RISK.\n\nYou will be awarded a certificate of successful completion of a Program (“Program Certificate”) upon fulfilling the criteria and requirements of Aurask, which Aurask may update from time to time. The decision to award any such Program Certificate or other acknowledgement of successful completion of a Program, would be solely at Aurask’s discretion. Aurask may choose not to offer any such Program Certificate or other acknowledgement of successful completion, for some Programs. Aurask may decide at its sole discretion whether to provide a record concerning a Customer’s performance in a Program. The format of any certificate, credential or other acknowledgement, and of any performance, provided by Aurask relating to a Program will be determined by Aurask at its sole discretion and may vary as per the Program.\n\nAurask has no obligation to have the Aurask Services, Aurask Content, Programs or Program Certificates recognized by or affiliated to any educational institution or accreditation organization. Aurask provides education related services through the Platform. The Platform or the Aurask Services MUST NOT be construed as a university. The Users understand and acknowledge that Aurask cannot award certificates which are recognised by any regulatory body such as the All India Council for Technical Education or University Grants Commission.\n\nIt is the sole responsibility of the Customer enrolling into a Program to check the accuracy of, and evaluate the suitability and relevance of, the Program elected. The enrolment into a Program is non-transferable.\n\nYou acknowledge that certain parts of the Platform may be enabled by third-party service providers, and you agree to abide by their terms and conditions to the extent such terms are applicable to you. Aurask shall not be responsible for any disruption of Aurask Services caused by any such third-party service provider.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Indemnification",
      "subtitle":
          "You shall defend, indemnify, and hold harmless Aurask, its affiliates, subsidiaries and each of its, and its affiliates’ and subsidiaries’ employees, contractors, directors, suppliers and representatives from all liabilities, losses, claims, and expenses, including reasonable attorneys’ fees, that arise from or relate to (i) your use or misuse of, or access to, the Platform and/or Aurask Services; (ii) your violation of the ToS or any applicable law; (iii) your violation of any rights of a third party in relation to the usage of the Platform. We reserve the right to assume the exclusive defence and control of any matter otherwise subject to indemnification by you, in which event you will assist and cooperate with us in connection therewith.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Limitation of Liability",
      "subtitle":
          "TO THE FULLEST EXTENT PERMITTED BY LAW, IN NO EVENT SHALL Aurask (NOR ITS DIRECTORS, EMPLOYEES, AGENTS, SPONSORS, PARTNERS, SUPPLIERS, CONTENT PROVIDERS, LICENSORS OR RESELLERS,) BE LIABLE UNDER CONTRACT, TORT, STRICT LIABILITY, NEGLIGENCE OR ANY OTHER LEGAL OR EQUITABLE THEORY WITH RESPECT TO THE SERVICE (I) FOR ANY LOST PROFITS, DATA LOSS, LOSS OF GOODWILL OR OPPORTUNITY, OR SPECIAL, INDIRECT, INCIDENTAL, PUNITIVE, OR CONSEQUENTIAL DAMAGES OF ANY KIND WHATSOEVER; OR (II) FOR YOUR RELIANCE ON THE Aurask SERVICES; OR (III) FOR ANY DIRECT DAMAGES IN EXCESS (IN THE AGGREGATE) OF ONE THOUSAND RUPEES (INR 1,000/-); OR (IV) FOR ANY MATTER BEYOND ITS REASONABLE CONTROL, EVEN IF Aurask HAS BEEN ADVISED OF THE POSSIBILITY OF ANY OF THE AFOREMENTIONED DAMAGES.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Governing Law",
      "subtitle":
          "The ToS shall be governed by and construed in accordance with the laws of India without regard to the conflict of laws provisions thereof. All claims, differences and disputes arising under or in connection with or in relation hereto the Platform, the ToS or any transactions entered into on or through the Platform shall be subject to the exclusive jurisdiction of the courts at Bengaluru, India and you hereby accede to and accept the jurisdiction of such courts.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Payments",
      "subtitle":
          "Unless otherwise expressly agreed in writing by Aurask, full payment for enrolment and participation in a Program is required at the time of registration. To make payment for any Program or to purchase any services or products offered by Aurask through the Platform, you must have internet access and a current valid accepted payment method as indicated on the Platform (“Payment Method”). Aurask does not store any of your credit card information or such other information restricted by the Reserve Bank of India (RBI) for processing payment and has partnered with payment gateways for the payment towards the services. By using a third-party payment provider, you agree to abide by the terms/policies of such third-party payment provider. You agree that in case Aurask’s third-party payment provider stores any such information, Aurask will not be responsible for such storage, and it will be solely at your discretion to allow the third party to store such information as per its terms/policies. Aurask shall in no way be liable for loss of such information or any loss incurred by you due to the misuse of such information and Aurask shall not be obligated to reimburse you for any such loss or to hold you harmless in any manner. You also agree to pay all applicable fees for the payments made through the Platform.\n\nAurask does not support all payment methods, currencies or locations for payment. All applicable taxes are calculated based on the billing information you provide to us at the time of enrolment/purchase. Your transactions on the Platform may be subject to foreign exchange fees or exchange rates.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Refund Policy",
      "subtitle":
          "A Customer may opt out of certain Programs subscribed by him/her and seek a refund for the fees already paid in relation thereto, provided the Customer informs us in writing regarding the same and seeks the refund prior to the expiry of the Refund Window (as detailed in the table below). The Refund Window is calculated from the date of the first class/session of the relevant Program subscribed by the Customer. We shall not entertain any requests related to refund of fees after the expiry of the Refund Window. IT MUST BE NOTED, THAT NOTWITHSTANDING THE MODE OF PAYMENT USED FOR PAYING THE FEES, THE REFUND SHALL ALWAYS BE MADE TO A BANK ACCOUNT (AS PER THE DETAILS PROVIDED BY THE CUSTOMER) THROUGH NEFT/IMPS/RTGS OR SUCH OTHER FACILITY AS DEEMED FIT BY Aurask. WE MAY REQUEST FOR INFORMATION/DOCUMENTS (WHICH MAY INCLUDE A CANCELLED CHEQUE PERTAINING TO THE BANK ACCOUNT OF THE CUSTOMER) TO VERIFY YOUR CREDENTIALS AND DETAILS OF THE BANK ACCOUNT BEFORE INITIATING THE REFUND. WE SHALL STRIVE TO PROCESS THE REFUNDS WITHIN THIRTY (30) DAYS OF RECEIPT OF ALL THE RELEVANT INFORMATION AND DOCUMENTATION FROM YOU IN THIS REGARD. We do not provide refunds for the lack of usage, dissatisfaction with the Program or for any reason whatsoever after the expiry of the Refund Window.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Policy for NDNC",
      "subtitle":
          "By using the Website and/or registering yourself at Aurask.com you authorise us to contact you via email or phone call or sms and offer you our services, imparting product knowledge, offer promotional offers running on website & offers offered by the associated third parties, for which reasons, personally identifiable information may be collected. And irrespective of the fact if also you have registered yourself under DND or DNC or NCPR service, you still authorise us to give you a call from Aurask Academy for the above mentioned purposes till 365 days of your registration with us. This Privacy Policy covers Aurask Academy's treatment of personally identifiable information that Aurask Academy collects when you are on the Aurask Academy's site, and when you use Aurask Academy's services. This policy also covers Aurask Academy's treatment of personally identifiable information that Aurask Academy's business partner shares with Aurask Academy. This policy does not apply to the certain Aurask Academy's products or services, when you visit Aurask Academy's pages, and when you enter promotions. Aurask Academy may also receive personally identifiable information from our business partners. When you registered with Aurask Academy, we ask for your first name, last name, contact no, email, Date of Birth and gender. Once you register with Aurask Academy and sign in to our services, you are not anonymous to us. Also during registration, you may be requested to register your mobile phone and email id, pager, or other device to receive text messages, and other services to your wireless device. By registration you authorise us to send sms/email alerts to you for your login details and any other service requirements or some advertising messages/emails from us.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Copyright Infringement Notice",
      "subtitle":
          "If a User believes in good faith that his/her copyright has been infringed, the User may provide us with a written communication which contains:",
      "points": [
        "An electronic or physical signature of the person authorized to act on behalf of the owner of the copyright interest/work",
        "A description of the copyrighted work that the User claims has been infringed upon",
        "A description of where the material that the User claims is infringing is located on the Platform, and any other details identifying the infringing material",
        "The User’s email address, address and telephone number",
        "A statement by the User affirming that the User has a good faith belief that the disputed use is not authorized by the copyright owner, his/her agent, or the law",
        "A statement by the User, made under penalty of perjury, that the information in the copyright notice is accurate and that the User is the copyright owner or authorized to act on behalf of the copyright owner."
      ],
      "bottom":
          "The Copyright infringement notice needs to be sent to the following address:\nAttention: Vinay Yadav\n\nAddress: Hyderabad\n\nEmail: goflexee@gmail.com"
    },
    {
      "title": "Miscellaneous",
      "subtitle": "",
      "points": [
        "If any provision of the ToS is found to be unenforceable or invalid, that provision will be limited or eliminated to the minimum extent necessary so that the ToS will otherwise remain in full force and effect and enforceable.",
        "Any failure by Aurask to enforce any right or failure to act with respect to any breach by you under the ToS shall not be construed as, or constitute, a continuing waiver of such provision, or a waiver of any other breach of or failure to comply with any other provision of the ToS, unless any such waiver has been consented to by us in writing.",
        "These ToS is personal to you and is not assignable or transferable by you except with Aurask’s prior written consent. Aurask may assign, transfer or delegate any of its rights and obligations hereunder without your consent.",
        "No agency, partnership, joint venture, or employment relationship is created as a result of the ToS and neither party has any authority of any kind to bind the other in any respect in relation to any third party.",
        "All notices under the ToS will be in writing and will be deemed to have been duly given when received, if personally delivered or sent by certified or registered mail, return receipt requested; when receipt is electronically confirmed, if transmitted by facsimile or e-mail; or two days after it is sent, if sent for next day delivery by recognized overnight delivery service.",
        "Aurask shall not be liable for failure to perform, or the delay in performance of, any of its obligations if, and to the extent that, such failure or delay is caused by events substantially beyond its control, including but not limited to acts of God, acts of the public enemy or governmental body in its sovereign or contractual capacity, war, terrorism, floods, fire, strikes, pandemics, epidemics, civil unrest or riots, power outage, and/or unusually severe weather.",
        "By accepting the ToS through your use of the Platform, you certify and acknowledge that you are 18 years of age or older. If you are under the age of 18 or under the legal age in your jurisdiction to enter into a binding contract, you must use the Platform only under the supervision of a parent or legal guardian who agrees to be bound by the ToS. If you are a parent or legal guardian agreeing to this ToS for the benefit of an individual below 18 year of age, please be advised that you are fully responsible for his/her use of the Platform, including all financial charges and legal liability that he/she may incur. By using the Platform, you represent and warrant that you have the right, authority, and capacity to enter into this ToS and to abide by all of the terms and conditions set forth herein."
      ],
      "bottom": ""
    },
    {
      "title": "Definitions",
      "subtitle":
          "The following defined terms having their respective meanings as provided below have been used in these ToS:",
      "points": [],
      "bottom":
          "“Customer” refers to any User who has paid and subscribed to any of the Programs, which may include execution of a subscription agreement (or any similar agreement executed between such User and Aurask) or compliance with certain additional terms by the User in this regard; “Platform” shall mean the websites www.Aurask.com and www.Aurask.com (collectively, the “Website”), and any other platform (including chat groups, Aurask hosted social media forums/pages and webpages) which may allow you to access and/or use the Aurask Services via any other device/medium; “Aurask Content” means and includes all questionnaires, interview ideas, study/course material in any format, ideas, concepts, inventions, systems, platforms, software, interfaces, tools, utilities, templates, forms, techniques, design formats, methods, processes, algorithms, know-how, trade secrets, and other technologies and information acquired, created, developed or licensed independently by us, prior to or outside the scope of these ToS and any improvement, modification, extension or other derivative works thereof and all intellectual property rights thereto. Aurask Content excludes all User Data; “User Data” means all electronic data, information, or other content submitted or provided by a User to be stored, collected or processed by us in connection with such User’s authorised use of the Aurask Services; “ You ” or “ User ” shall mean any user of the Platform."
    },
  ];
}

//?https://www.Aurask.com/terms/

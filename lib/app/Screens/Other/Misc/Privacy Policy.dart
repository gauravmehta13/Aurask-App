import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../meta/Utility/Constants.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          "Privacy Policy",
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
                "(Last Updated: July 22, 2021)",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600, fontSize: 18),
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
      "title": "Introduction",
      "subtitle":
          "This Privacy Policy relates to the collection, use and disclosure of personal data, including special or sensitive personal data, by Aurask Software Services Private Limited and Aurask Technologies Pvt Ltd. (“Aurask“, “Aurask”, “we“, or “our“). Personal Data is information relating to an individual (“you“ or “your“) as more fully defined herein below. Aurask is committed to protecting your privacy and ensuring that you have a secured experience on our website and while using our products and services (collectively, “Products“).\n\nThis policy covers the Aurask website and all the subdomains under Aurask.com . Please refer to the following link to read our terms of service Terms of service.\n\nThis policy outlines Aurask's, its subsidiaries and affiliated companies handling practices and how we collect and use the information you provide in the course of your use or access of our systems through online interfaces (e.g. website, mobile applications etc.) (collectively “Company Systems“). In this Privacy Policy, “Personal Data” means any information that can be used to individually identify a person and may include, but is not limited to, name, email address, postal or other physical addresses, title, and other personally identifiable information. By using our services or products, it will be deemed that you have read, understood and agreed to be bound by this policy detailed hereunder",
      "points": [],
      "bottom":
          "We will be the processor of the Personal Data that is provided, collected and/or processed pursuant to this policy, except where otherwise expressly stated."
    },
    {
      "title": "Applicability of the Policy",
      "subtitle": "",
      "points": [
        "This policy shall apply to all information we collect through the Company Systems and/or in the course of your use of the services of Aurask.",
        "This policy does not apply to, nor does Aurask take any responsibility for, any information that is collected by any third party either using Company Systems or through any links on the Company Systems or through any of the advertisements or through BOTS."
      ],
      "bottom": ""
    },
    {
      "title": "Information We Collect",
      "subtitle":
          "We will only collect information which you share with us. You can choose what information you want to share with us. We will collect your information only if you choose to share it through the Company Systems. We will collect the following information about you or related to your use of the Company’s Systems:",
      "points": [
        "Any personal or PII that you may submit or may be required to submit for registration and continued use of the Company Systems or receive the services by Aurask;",
        "Your name, title, gender, date of birth, email address, telephone number (Home/work/mobile telephonic number), profile/display picture, login name, screen name, nickname, or handle, country/state/postcode or city of residence, postal or other physical address, name(s) of the school/university (including grades and graduation year),name(s) of the workplace, job position/designation (including salary), resume/CV, information related to social profiles, such as Facebook, Google, GitHub etc., IP addresses and other information collected passively (as further detailed in the “Passive Collection” section below), may be collected; and",
        "Any other information you may choose to further provide us, without limitation, any information to update your account and profile, if required, to fill out any forms, provide your feedback to surveys, write any articles onthe Company Systems, or to use any features of Company Systems."
      ],
      "bottom":
          "Please do not include any personal information, personally identifiable information or sensitive personal information unless specifically requested by Aurask as part of the registration or other applicable processes. If Aurask determines that any information you have provided or uploaded violates the terms of this policy, Aurask shall have the right, in its absolute discretion, to delete such information without incurring any liability.\n\nWe may also periodically use your information received from your affiliated entities, business partners and other third-party sources and combine it with your account information. For example: if you access or login to our Company Systems via a third-party source like Facebook, Twitter, LinkedIn, we may receive your registration information, updated information and combine that with information we collect through our Company Systems or add it to your account information on our Company Systems.\n\nIf You are governed by the United States laws, to the extent permitted by applicable laws, we may obtain reports from public records of credit history checks, criminal databases checks including National Criminal Database and county courts in each state, national government restricted lists, sex offender registrations. If you are outside of the United States, to the extent permitted by applicable laws, Aurask may obtain reports of the respective criminal background or registered sex offender checks. To obtain such reports as stated herein, we may use your information, like your full name and date of birth.\n\nGeneral Data Protection Regulation (GDPR) is designed to give EU citizens more control over their data. It aims to use an all-encompassing privacy and security law to safeguard Personal Data. Irrespective of their location, GDPR applies to all the relevant controllers or processors who deal with the Personal Data of EU citizens."
    },
    {
      "title": "Processing your Personal Data",
      "subtitle":
          "We will use your Personal Data only in accordance with this policy. To enable us to fulfil the contract between us for the services you have requested, we need to process your Personal Data for purposes including the following:",
      "points": [
        "Account registration.",
        "Use of our website.",
        "Creating or taking online tests.",
        "Generating reports based on information collected from use of our Products.",
        "Requesting service and support for our Products and providing such support.",
        "Registering for hackathons.",
        "Participating in discussion groups or forums.",
        "Customizing the content you see as per relevance.",
        "Referring your profile to relevant job opportunities."
      ],
      "bottom":
          "We may allow employers to view your anonymised profile and contact you for a relevant job opportunity. We provide them with a channel to contact you for a relevant job opportunity. We share your PII with employers only with your explicit consent, or when you reply back to the conversation channel. If you wish to opt-out of this feature, please sendus an email to support@Aurask.com.\n\nWe may also process your personal data where it is in our legitimate interests to seek professional advice, including, in connection with any legal proceedings (including any prospective legal proceedings), for obtaining legal advice or for establishing, exercising or defending legal rights."
    },
    {
      "title": "Consent",
      "subtitle":
          "Your decision to provide Personal Data to Aurask is at your sole discretion and is deemed obtained when you register and create your account on our Company Systems. Please note that you may not be able to access certain options, offers, and services if they require Personal Data that you have not provided. You can sign-up, and therefore consent, to receive email or newsletter communication from us. If you would like to discontinue receiving this communication, you can update your preferences by using the ‘Unsubscribe’ link at the end of such emails or by contacting us through email on support@Aurask.com.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "How do we use your information?",
      "subtitle":
          "Aurask will use your Personal Data only in accordance with this policy. If you do not wish us to continue using your Personal Data in this manner you can request for deactivation of your account from account settings.\n\nWe will only process your Personal Data if we have a lawful basis for doing so, which includes but is not limited to the following:\n\nconsent, contractual necessity (i.e. processing that is necessary for the performance of a contract with you, such as your user agreement with us that allows us to provide you with the Products) and our legitimate interests or the legitimate interest of others (e.g. our users) such as:",
      "points": [
        "Provide you with the websites and services, together with any support you may request.",
        "Respond to your inquiries or fulfill your requests.",
        "Diagnose Website and Service technical problems.",
        "Send you information that we believe may be of interest to you, such as Service.",
        "Announcements, newsletters, educational materials, and event information.",
        "Send you administrative information such as notices related to the Services or policy changes.",
        "Understand how the Websites and Services are being used in order to enhance and optimize them.",
        "Prevent, detect, mitigate, and investigate fraudulent or illegal activity.",
        "As described to you at the point of collection of the information.",
        "Complying with our legal obligations, resolving disputes with users, enforcing our agreements.",
        "Protecting, investigating and deterring against fraudulent, harmful, unauthorized or illegal activity."
      ],
      "bottom": ""
    },
    {
      "title": "Your Rights:",
      "subtitle":
          "Rights:You have certain rights with respect to your Personal Data as mentioned below.",
      "points": [
        "Access: You can request more information about the Personal Data we hold about you. You can also request acopy of the Personal Data.",
        "Correction: If you believe that any Personal Data we are holding about you is incorrect or incomplete, you can request that we correct or supplement such data. You can also correct some of this information directly through your user profile or profile/account settings after logging into Aurask. Please contact us as soon as possible upon noticing any inaccuracies or incompleteness.",
        "Objection: You can contact us to let us know that you object to the collection or use of your Personal Data for certain purposes.",
        "Erasure: You can request that we delete some or all of your Personal Data from our systems. While this will be done immediately, residual data may be saved in certain logs and this will be purged within a year after deleting your data. Once your data is deleted, you will no longer have an account with Aurask.",
        "Restrictions: You can always request us to deactivate your Aurask account to restrict further processing of your Personal Data",
        "Portability: You have the right to ask for a copy of your Personal Data in a machine-readable format.",
        "Withdrawal of consent: If we are processing your Personal Data based on your consent (as indicated at the time of collection of such data), you have the right to withdraw your consent at any time. Please note, however, that if you exercise this right, you may have to then provide express consent on a case-by-case basis for the use or disclosure of certain of your Personal Data, if such use or disclosure is necessary to enable you to utilize some or all of our Products."
      ],
      "bottom": ""
    },
    {
      "title": "Retention",
      "subtitle":
          "Your data is retained with Aurask as long as you have an active account on the Company Systems. You can request that we delete some or all of your Personal Data from our systems. While this will be done within thirty (30) days from the date of such request, residual data may be saved in certain logs and this will be purged within a year after deleting your data. Once your data is deleted, you will no longer have an account with Aurask.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Passive Data collection:",
      "subtitle":
          "Aurask might automatically collect some data about you when you are using any of our products, using methods like cookies and other tracking technologies. Information automatically collected includes cookies, page views, geolocation data, IP(internet protocol) addresses, browser and OS(Operating System) type, ISP (Internet Service Provider), files viewed and downloaded from our websites, referral and exit pages and click stream data. Such data does not have an expiry date and we do not delete this data. This data is stored in the form of logs or in third party tracking and analytics softwares like Google analytics, Linkedin Insights etc.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "We Use Cookies:",
      "subtitle": "",
      "points": [
        "Aurask uses cookies to help us remember and process the items in your shopping cart. They are also used to help us understand your preferences based on previous or current site activity, which enables us to provide you with improved services. We also use cookies to help us compile aggregate data about site traffic and site interaction so that we can offer better site experiences and tools in the future. Further, we may use cookies or other tracking technologies to analyze trends, track users’ movements around the website, and gather information about our user base, such as location information based on IP addresses.",
        "You can choose to have your computer warn you each time a cookie is being sent, or you can choose to turn off all cookies. You do this through your browser (like Internet Explorer) settings. Each browser is a little different, so look at your browser's Help menu to learn the correct way to modify your cookies.",
        "If you disable cookies off, some features will be disabled. It won't affect the user's experience that makes your site experience more efficient and some of our services will not function properly.",
        "Aurask may collect information related to visitors and machines. Such information includes cookies, IP addresses, pageview activities, and geolocation data. The details of user activities on our website such as number of visits, time spent on our website, and pages clicked are also collected"
      ],
      "bottom": ""
    },
    {
      "title": "To whom we may disclose your Personal Data:",
      "subtitle":
          "General: The information you provide on the Company Systems may be disclosed by Aurask to its employees, agents, representatives, consultants, subsidiaries, affiliates and third-party providers who require the information for the purposes of (a) operating and maintaining the Company Systems, (b) data processing or storage.\n\nHiring Partners: We may provide your data to our hiring partners after taking your consent. We provide resumes, phone numbers, email addresses and other relevant information to our hiring partners to enable users to get job offers. Events of Reorganization: In any given instance, if Aurask undergoes any events of reorganization, merger, acquisition, insolvency or bankruptcy, Aurask may sell, transfer or share some or all of our assets, including your information, subject to notification to You pertaining to transfer of Your information.\n\nApplicable Laws: Aurask will comply with requests and directions of all governmental, law enforcement, court or regulatory authorities, which it believes in good faith to be in accordance with any applicable law. Such compliance may include disclosing to the governmental, law enforcement, courts, or regulatory authorities’ information submitted by you or collected in relation to your use of the Company Systems or Aurask's services including any personally identifiable information. By using the Company Systems and receiving Aurask services, you consent to Aurask’s disclosure of information as set out in this Section herein to governmental, law enforcement, courts or regulatory authorities\n\nAurask will not publish, sell or rent Your personal information to third-parties for their marketing purposes without Your explicit consent.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Data Security:",
      "subtitle":
          "The information that you provide, subject to disclosure in accordance with this policy, shall be maintained in a safe and secure manner. Your information shall be protected, to a commercially reasonable extent, against unauthorized access, use, or disclosure. Our databases and information are stored on secure servers with appropriate firewalls. Further, we use vulnerability scanning and scanning to PCI standards annually and our Company Systems are subject to regular Malware Scanning. Additionally, we use SSL certificate to encrypt all the data being transferred.\n\nAs a user of the Company Systems, you have the responsibility to ensure data security. You must not disclose to any person the authentication parameters that are assigned to you including Your username or password for your use of the Company Systems. You acknowledge that you will be solely responsible for all acts committed by use of your username /other authentication parameters.\n\nGiven the nature of internet transactions, Aurask does not take any responsibility for the transmission of information collected from you or are generated by your use of the Company Systems or the services. Any transmission of such information over the internet is done at your sole risk. Aurask does not take any responsibility for you or any third party circumventing the privacy settings or security measures contained on the Company Systems.\n\nNotwithstanding anything to the contrary, while Aurask will use all reasonable efforts to ensure that any information collected from you or are generated by your use of the Company Systems or the services is safe and secure, it offers no representations or warranties that the security measures are adequate, safe, fool proof or impenetrable.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Integration with Linked Websites and Third-Party Websites:",
      "subtitle":
          "Links to external, or third-party websites, may be provided solely for your convenience. Such links from us to an external website does not imply or mean that Aurask endorses or accepts any responsibility for the content or the use of such a website. Aurask does not give any representation regarding the quality, safety, suitability, or reliability of any external websites or any of the content or materials contained in them. It is important for you to take necessary precautions, especially to ensure appropriate safety from viruses, worms, Trojan horses and other potentially destructive items.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Third-party Ad Networks:",
      "subtitle":
          "Our Website may use third party network advertisers to display advertisements about our Products on third party websites, based on your visits to our site as well as other websites. This enables us and these third parties to target advertisements by displaying ads for our Products which might interest you.",
      "points": [],
      "bottom":
          "Third party network advertisers’ services may use cookies, JavaScript, and other technologies to make their ads effective and to personalize them to connect to you. These third-party cookies and other technologies are governed by each third party’s specific privacy policy, and not this one. We may provide these third-party advertisers with anonymized and aggregated information about your usage of our website and our Products; however, we do not share your Personal Data with these third parties. You also have the option of denying the access of data to such third-party ad networks."
    },
    {
      "title": "Anonymized Information:",
      "subtitle":
          "Notwithstanding anything to the contrary in this policy, Aurask may use any information provided to Aurask in relation to or as part of the services in providing services to its other clients and to develop and create reports, statistical analysis, and benchmarking analyses for its clients provided that such reports contain only anonymous, aggregated dataand do not identify you by name.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Age Restrictions:",
      "subtitle":
          "You explicitly agree you are 18 years of age or older, unless represented by a parent or legal guardian. If you are not of the requisite age you must not provide any information to Aurask directly or by way of usage of the Company Systems. If Aurask determines that it is in possession of any information belonging to an individual below 18 years of age which is submitted, collected or generated in breach of the terms of this Policy, it will delete the same without any notice to the individual to whom such information belongs to.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Update:",
      "subtitle":
          "This policy may be updated from time-to-time so we recommend that you regularly review this policy each time you return to our website.",
      "points": [],
      "bottom": ""
    },
    {
      "title": "Grievance:",
      "subtitle":
          "If you have any issue or grievance with respect to our policy or with the manner in which we collect or store your information, or in any respect related to your personal information provided to us, please contact hello@Aurask.com. We will do everything we reasonably can to ensure that your grievance is attended to and addressed within a period of 30 days from the date of receipt of Your grievance.",
      "points": [],
      "bottom": ""
    },
  ];
}

//?https://www.scaler.com/privacy/

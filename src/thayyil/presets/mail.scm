(define-module (thayyil presets mail)
  #:use-module (rde features mail))

(define msmtp-provider-settings
  (append
   `((outlook . ((host . "smtp-mail.outlook.com")
                 (port . 587))))
   %default-msmtp-provider-settings))

(define outlook-folder-mapping
  '(("inbox"   . "INBOX")
    ("sent"    . "[Outlook]/Sent Items")
    ("drafts"  . "[Outlook]/Drafts")
    ("archive" . "[Outlook]/All Mail")
    ("trash"   . "[Outlook]/Trash")
    ("spam"    . "[Outlook]/Spam")))

(define outlook-isync-settings
  (generate-isync-serializer "outlook.office365.com" outlook-folder-mapping))

(define isync-serializers
  (append
   `((outlook . ,outlook-isync-settings))
   %default-isync-serializers))

(define-public thayyil-email-set
  (list
   (feature-isync
    #:isync-serializers isync-serializers)
   (feature-l2md)
   (feature-msmtp
    #:msmtp-provider-settings msmtp-provider-settings)))

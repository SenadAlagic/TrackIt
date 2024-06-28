using Newtonsoft.Json;
using System.Net;
using System.Net.Mail;

namespace TrackIt.Subscriber
{
	public class EmailService
	{
		public void SendEmail(string message)
		{
			try
			{
				string smtpServer = Environment.GetEnvironmentVariable("SMTP_SERVER") ?? "smtp.gmail.com";
				int smtpPort = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT") ?? "587");
				string fromMail = Environment.GetEnvironmentVariable("SMTP_USERNAME") ?? "trackitapprs2@gmail.com";
				string password = Environment.GetEnvironmentVariable("SMTP_PASSWORD") ?? "rzmk cavd xbbb taat";

				var emailData = JsonConvert.DeserializeObject<EmailModel>(message);
				var senderEmail = emailData.Sender;
				var recipientEmail = emailData.Recipient;
				var subject = emailData.Subject;
				var content = emailData.Content;

				MailMessage MailMessageObj = new MailMessage();

				MailMessageObj.From = new MailAddress(fromMail);
				MailMessageObj.Subject = subject;
				MailMessageObj.To.Add(recipientEmail);
				MailMessageObj.Body = content;

				var smtpClient = new SmtpClient()
				{
					Host = smtpServer,
					Port = smtpPort,
					Credentials = new NetworkCredential(fromMail, password),
					EnableSsl = true
				};

				smtpClient.Send(MailMessageObj);
			}
			catch (Exception ex)
			{
				Console.WriteLine($"Error sending email: {ex.Message}");
			}
		}
	}
}

# RateLimitTester

Web ve dış ağ penetrasyon testlerinde kullandığım "feroxbuster" toolu ile çalışan , domain listesindeki tüm domainlere sırayla HTTP isteği gönderip HTTP Rate Limit testini yapan, saniyede kaç istek gönderilebiliyor bunları otomatize eden bir bash scriptidir.

NASIL KULLANILIR ? 

"domains.txt" dosyasına test etmek istediğiniz domain adreslerini kaydedin.

Bash scriptini kopyalayın ve ".sh" uzantılı bir dosya oluşturun.Örneğin : cat > ratelimittester.sh

Daha sonrasında ise bu dosyaya yürütülebilir iznini verin. chmod +x ratelimittester.sh

Terminal üzerinden " ./ratelimittester.sh " çalıştırabilirsiniz.

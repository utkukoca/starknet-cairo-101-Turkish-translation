# StarkNet Cairo 101
**Bu basit eğitimle Cairo kullanmaya başlayın. 
Bulmacaları/egzersizleri tamamlayın, egzersizleri yaptıkça token kazanın ve StarkNet akıllı sözleşmeleri hakkında bilgi edinin!​**
​
  ## Giriş
### Sorumluluk reddi
​
Ethereum Mainnet'teki "ilk genel amaçlı validity rollup olan StarkNet" hakkında bir sürü harika şey öğrenmek dışında, bunu kullanmaktan herhangi bir fayda beklemeyin.
​
StarkNet hala Alfa'da. Bu, geliştirmenin devam ettiği ve boyanın her yerde kurumadığı (son sürüm olmadığı) anlamına gelir. İşler daha iyi olacak ve bu arada, burada ve orada biraz koli bandıyla işleri yürütüyoruz!
​
## Nasıl çalışır
​
**Alıştırmaları bitir tokenları al!**
Bu atölye, testnet'te "StarkNet Alpha'da" bulunan bir dizi akıllı sözleşmedir.
Her akıllı sözleşme, Cairo Akıllı sözleşme dilinin bir özelliğini anlatan/özetleyen bir alıştırma/bulmacadır.
Alıştırmayı tamamlamak, size token şeklinde kredi verecektir [ERC20 token](contracts/token/TDERC20.cairo).
​
Bu atölye, sözdizimini anlamak için Cairo kodunu ve StarkNet akıllı sözleşmelerini *okumaya* odaklanır.
Takip etmek ve tamamlamak için makinenize herhangi bir kod yazmanıza veya herhangi bir şey yüklemenize gerek yoktur.
​
Başlamak (ilk iki alıştırmayı yapmak) öğreticiyi anlamak için biraz zaman alacaktır. Hatta beklemek! Bir kez orada, işler daha kolay akacak. Öğreniyorsun!
​
u atölye, geniş akıllı sözleşme kavramlarını (ERC20/ERC721 yazma ve dağıtma, varlıklar arasında köprü oluşturma, L1 <-> L2 mesajlaşma...) kapsayacak bir serinin ilkidir.
Bunları yazmakla ilgileniyor musunuz?[Reach out](https://twitter.com/HenriLieutaud)!
​
### Geri bildirim sağlama
Bu öğretici üzerinde çalışmayı bitirdikten sonra, geri bildiriminiz çok takdir edilecektir!
**Daha iyi hale getirmek için ne yapacağımızı bilmemiz için lütfen bu formu doldurun [bu formu](https://forms.reform.app/starkware/untitled-form-4/kaes2e).** 
​
Ve ilerlemekte zorlanıyorsanız, bize bildirin! Bu eğitimin mümkün olduğu kadar erişilebilir olması amaçlanmıştır;eğer değilse öyle olmadığını bilmek istiyoruz.
​
Sorunuz mu var? Katılın --> [Discord server](https://discord.gg/B7PevJGCCw), kayıt olun and kanala katılın #tutorials-support
​
## Başlarken
​
### Cüzdan kontratı oluşturun.
**Eğitimi tamamlamak için puan toplamanız gerekiyor.** Bu puanlar, yüklemeniz gereken bir akıllı sözleşme cüzdanına ait olacaktır.
-   Şu an bunu oluşturmanın en kolay yolu Argent X kullanmaktır ([download the chrome extension](https://chrome.google.com/webstore/detail/argent-x-starknet-wallet/dlcobpjiigpikoobohmabehhmhfoodbb/)  veya  [check their repo](https://github.com/argentlabs/argent-x)).
-   Uzantıyı yüklemek ve bir cüzdan sözleşmesi dağıtmak için talimatları izleyin
-   Goerli testnet network'de olduğunuzdan emin olun.
-   Eğitimin puanları `0x074002c7df47096f490a1a89b086b8a468f2e7c686e04a024d93b7c59f934f83` sözleşmesinde tutulur. Puan bakiyenizin orada görünmesini sağlamak için Argent X'te "token ekle"ye tıklayın!
- Voyager'ı hesap sözleşmenize bağlayın! Bu, işlemlerinizi cüzdanınız aracılığıyla yayınlamanıza olanak tanır.
​
### Voyager'ı kullanma
Bu eğitim için sözleşmelerimizle [Voyager](https://goerli.voyager.online/) ile etkileşimde bulunacağız. StarkNet's block explorer. 

-> Voyager'ı cüzdanınıza bağlayın! Bu, işlemlerinizi cüzdanınız aracılığıyla yayınlamanıza olanak tanır.


Bir sözleşme/işlem ararken daima Voyager'ın Goerli "testnet" versiyonunda olduğunuzdan emin olun!
-   İşlemlerinize URL ile erişin [https://goerli.voyager.online/tx/your-tx-hash](https://goerli.voyager.online/tx/your-tx-hash)
-   URL ile bir sözleşmeye erişin  [https://goerli.voyager.online/contract/your-contract-address](https://goerli.voyager.online/contract/your-contract-address)
-   Voyager'daki "sözleşmeyi oku/yaz" sekmesi ile sözleşmenin okuma/yazma işlevlerine erişin.
​
### Puan kazanmak
​
​
**Her alıştırma ayrı bir akıllı sözleşmedir.** Düzgün yürütüldüğünde puanları adresinize gönderecek bir kod içerir. Şu anda hesap sözleşmenizle kolayca işlem göndermenin bir yolu olmadığından, her egzersiz sonunda puanlarınızı almanız için adresinizi belirtmeniz gerekecek..
​
Puanlar `distribute_points()` fonksiyonu sayesinde dağıtılacak 'validate_exercice' işlevi, alıştırmayı tamamladığınızı kaydederken (sadece bir kez puan alabilirsiniz). Amacınız:

![Graph](assets/diagram.png)
​
​
​
### İlerlemenizi kontrol etme
​
#### Puanlarınızı sayma
​
Puanlarınız Argent X'e aktarılacak; bu biraz zaman alabilir. Puan sayınızı gerçek zamanlı olarak izlemek istiyorsanız, bakiyenizi voyager'da da görebilirsiniz!
​
-   [ERC20 counter](https://goerli.voyager.online/contract/0x074002c7df47096f490a1a89b086b8a468f2e7c686e04a024d93b7c59f934f83#readContract) gidiniz ve  in voyager'da bulunan kontratı oku "read contract" sekmesini seçiniz
-   "balanceOf" fonksiyonuna cüzdan adresinizi giriniz.
​
#### İşlem durumu
​
Bir işlem gönderdiniz ve voyager'da "tespit edilmedi" olarak mı gösteriliyor? Bu iki anlama gelebilir:
​
-   İşleminiz beklemede ve kısa süre içinde bir bloğa eklenecek. Daha sonra voyager'da görünür olacak. "testnet olduğu için zaman alabilir"
-   İşleminiz geçersizdi ve bir bloğa EKLENMEYECEK (StarkNet'te başarısız işlem diye bir şey yoktur).
​

İşleminizin durumunu aşağıdaki URL ile kontrol edebilirsiniz (ve yapmalısınız). [https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=](https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=)  , işlem hash'inizi ekleyebileceğiniz yer.
​
### Alıştırmalar ve Sözleşme adresleri.
### Sözleşme Adresleri
|Topic|Contract code|Contract on voyager|
|---|---|---|
|Points counter ERC20|[Points counter ERC20](contracts/token/TDERC20.cairo)|[Link](https://goerli.voyager.online/contract/0x074002c7df47096f490a1a89b086b8a468f2e7c686e04a024d93b7c59f934f83)|
|General syntax|[Ex01](contracts/ex01.cairo)|[Link](https://goerli.voyager.online/contract/0x04b9b3cea3d4b21f7f272a26cf0d54f40348a9d8509f951b217e33d4e9c80af2)|
|Storage variables, getters, asserts|[Ex02](contracts/ex02.cairo)|[Link](https://goerli.voyager.online/contract/0x06511a41c0620d756ff9e3c6b27d5aea2d9b65e162abdec72c4d746c0a1aca05)|
|Reading and writing storage variables|[Ex03](contracts/ex03.cairo)|[Link](https://goerli.voyager.online/contract/0x044a68c9052a5208a46aee5d0af6f6a3e30686ab9ce3e852c4b817d0a76f2f09)|
|Mappings|[Ex04](contracts/ex04.cairo)|[Link](https://goerli.voyager.online/contract/0x04e701814214c5d82215a134c31029986b0d05a2592c0c977fe2330263dc7304)|
|Variable visibility|[Ex05](contracts/ex05.cairo)|[Link](https://goerli.voyager.online/contract/0x01e7285636d7d147df6e2eacb044611e13ce79048c4ac21d0209c8c923108975)|
|Functions visibility|[Ex06](contracts/ex06.cairo)|[Link](https://goerli.voyager.online/contract/0x02abaa69541bd4630225cd69fa87d08a6e8fb80f4c7c2e8d3568fa59e71eec26)|
|Comparing values|[Ex07](contracts/ex07.cairo)|[Link](https://goerli.voyager.online/contract/0x07d9f4f818592b7a97f2c7e5915733ed022f96313cb61bde2c27a9fbd729a5a4)|
|Recursions level 1|[Ex08](contracts/ex08.cairo)|[Link](https://goerli.voyager.online/contract/0x072d42eb599c9ec14d1f7209223226cb1436898c6930480c6a2f6998c6ceb9fe)|
|Recursions level 2|[Ex09](contracts/ex09.cairo)|[Link](https://goerli.voyager.online/contract/0x035203b6c0b68ef87127a7d77f36de4279ceb79ea2d8099f854f51fc28074de4)|
|Composability|[Ex10](contracts/ex10.cairo)|[Link](https://goerli.voyager.online/contract/0x071e59fbd7e724b94ad1f6d4bba1ff7161a834c6b19c4b88719ad640d5a6105c)|
|Importing functions|[Ex11](contracts/ex11.cairo)|[Link](https://goerli.voyager.online/contract/0x06e124eba8dcf1ebe207d6adb366193511373801b49742b39ace5c868b795e68)|
|Events|[Ex12](contracts/ex12.cairo)|[Link](https://goerli.voyager.online/contract/0x0658e159d61d4428b6d5fa90aa20083786674c49a645fe416fc4c35b145f8a83)|
|Privacy on StarkNet|[Ex13](contracts/ex13.cairo)|[Link](https://goerli.voyager.online/contract/0x07b271402ce18e1bcc1b64f555cdc23693b0eb091d71644f72b6c220814c1425)|

​
​
## Katkı
### Yardıma açığız!
Bu proje daha iyi hale getirilebilir ve önümüzdeki haftalarda gelişecektir. Katkılarınız için teşekürler! Yardımcı olmak için yapabileceğiniz şeyler şunlardır:
- Hata bulursanız düzeltiniz
- Daha fazla açıklamaya ihtiyaç olduğunu düşünüyorsanız, alıştırmanın yorumlarına açıklama ekleyin.
- En sevdiğiniz Cair özelliğini sergileyen alıştırmalar ekleyin
​
### Bu projeyi yeniden kullanmak
- Repoyu makinenizde klonlayın
- [bu talimatları] izleyerek ortamı kurun(https://starknet.io/docs/quickstart.html#quickstart)
- Yükleyin [Nile](https://github.com/OpenZeppelin/nile).
- Projeyi derleyebildiğinizi test edin
```
nile compile
```

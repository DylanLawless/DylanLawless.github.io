---
layout: topic
title: Cryptography
created: 28 Feb 2012
tags: statistics
status: finished
subject: cryptography
---

## Introduction

Cryptography is a fascinating topic with a long and interesting history. Popular stories include the use of cryptography during WWII, and espionage stories such as those written by Ben Macintyre. The field of modern cryptography, however, requires a technical understanding. Resources such as Computerphile on YouTube can provide insight into the topic. 

## Breaking crypto
Understanding how cryptography works and how it can be broken is best done simultaneously. A clear grasp on modular arithmetic is essential, as it forms the basis for many cryptographic algorithms. Modular arithmetic involves performing arithmetic operations on integers that are restricted to a certain range, called the modulus. This concept can be illustrated with an example involving a clock. For instance, we can use Mod 12 on a clock, where 12 is the modulus. If it is 1pm and we have been up since 12am, then we have been up for 13 hours. However, 13 mod 12 is equal to 1, so we have been up for 1 hour on the clock.
The page found [here](https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/what-is-modular-arithmetic) describes modular arithmetic very well. 

Modular arithmetic is used in many cryptographic algorithms, such as RSA. Shor's algorithm is a quantum computing algorithm that can be used to break RSA and other similar algorithms. A video that explains Shor's algorithm in a clear and concise way can be found [here](https://www.youtube.com/watch?v=12Q3Mrh03Gk).

Other examples of cryptographic algorithms that rely on modular arithmetic include the Diffie-Hellman key exchange, which is used to establish a shared secret between two parties over an insecure channel, and the ElGamal encryption scheme, which is used to encrypt messages. These algorithms are all based on the properties of modular arithmetic and the difficulty of solving certain mathematical problems, such as the discrete logarithm problem.

By understanding modular arithmetic and its applications in cryptography, we can better understand how cryptographic algorithms work and how they can be broken.

## AES is the most important current encryption method

The Advanced Encryption Standard (AES) is currently the most important encryption method. An introductory video on AES can be found [here](https://www.youtube.com/watch?v=x1v2tX4_dkQ). The book ["Cryptography: Theory and Practice"](http://www.crypto-textbook.com) is an excellent textbook on the subject. 

## Most common cryptography methods

| Method | Description |
| --- | --- |
| AES | A symmetric key encryption standard |
| RSA | An asymmetric key encryption standard |
| DES | A symmetric key encryption standard |
| Blowfish | A symmetric key encryption algorithm |
| Twofish | A symmetric key encryption algorithm |
| RC4 | A symmetric key encryption algorithm |

## Important names of cryptographic protocols

- RSA
- Diffie-Hellman
- AES
- Blowfish
- Twofish
- RC4

## Quantum computing

Quantum computing is a fascinating topic that has the potential to revolutionize computer security. A brief introduction to quantum computing can be found in these two videos from PBS: [How quantum computing works](https://www.youtube.com/watch?v=IrbJYsep45E) and [How might quantum computing destroy computer security?](https://www.youtube.com/watch?v=wUwZZaI5u0c).


## Public Key Cryptography

Public key cryptography is a type of encryption that uses two different keys, one for encryption and one for decryption. It was first introduced in the 1970s and has become a crucial component of modern cryptography. Public key cryptography is used in many applications, including secure communication, digital signatures, and key exchange.


## Blockchain and Cryptocurrency

Blockchain is a distributed ledger technology that is used to create a secure and transparent record of transactions. It was first introduced in 2008 as part of the Bitcoin cryptocurrency, but has since been applied to many other applications. Blockchain is considered to be highly secure due to its decentralized nature and use of cryptography.

## Post-Quantum Cryptography

Post-quantum cryptography is a new area of cryptography that focuses on developing algorithms that are resistant to attacks by quantum computers. Quantum computers are expected to be able to break many of the existing encryption algorithms that are currently in use, which is why post-quantum cryptography is becoming increasingly important.


## Homomorphic Encryption

Homomorphic encryption is a type of encryption that allows computations to be performed on encrypted data without first decrypting it. This has important applications in secure computing, especially in cloud computing, where data is often stored on remote servers. Homomorphic encryption allows users to perform computations on their data without revealing it to the cloud provider.


## Cryptography in the Internet of Things

The Internet of Things (IoT) is a network of devices that are connected to the internet and are able to exchange data. This presents many challenges for security and privacy, especially since many IoT devices are often low-power and have limited processing capabilities. Cryptography plays an important role in securing IoT devices and protecting the privacy of their users.

## Medical data
The need for privacy and security of medical data is critical in today's digital age. Medical data is highly sensitive and can contain personal information that needs to be protected from malicious actors who may use it for fraudulent purposes. Cryptography plays a vital role in ensuring that medical data remains secure and private.

However, it is important to note that while encryption provides an additional layer of protection for medical data, ultimately the person handling the data is in control. They have the ability to grant or deny access to the decrypted data. This is where trust becomes an important factor, as the individual must be trusted to handle the data responsibly and not misuse or disclose it without authorization.

New methods of encryption, such as homomorphic encryption, are being developed to improve the protection of medical data. Homomorphic encryption allows data to be encrypted while still allowing computations to be performed on it without the need for decryption. This method of encryption can provide additional protection as it eliminates the need for decrypted access to sensitive data.

Despite the benefits of homomorphic encryption, it is not yet widely used in the healthcare industry. The implementation of new technologies often faces challenges, such as compatibility issues and cost, that can hinder their adoption. Additionally, there may be concerns about the potential impact on the speed and efficiency of data processing.

Cryptography is essential for the protection of medical data, but it is important to acknowledge that the person handling the data ultimately has control over its access. While new methods of encryption such as homomorphic encryption are improving protection, they are not yet widely used in the healthcare industry. The adoption of these new technologies requires careful consideration of the potential benefits and challenges they may bring.


## Some thoughts

"Cybersecurity and Cyberwar" by Peter Warren Singer is an excellent book on the subject of cybersecurity. A talk based on this book can be found [here](https://www.youtube.com/watch?v=h0SXO5KUZIo). The [Security Engineering](https://www.cl.cam.ac.uk/~rja14/book.html) book is another great resource.

The [Cryptopals crypto challenges](http://www.cryptopals.com/) are a fun way to learn how to apply cryptographic techniques.

There are countless reasons why cryptography is interesting, ranging from mundane day-to-day applications like banking and personal communication to the hypothetical academic applications. The infrastructure required for modern electronic communication is quite extensive, and resources such as the [Submarine Cable Map](http://www.submarinecablemap.com) can provide insight into this topic. 


## Reading list on more advanced topics

### Websites and Online Resources

- [/r/crypto wiki](https://www.reddit.com/r/crypto/wiki/index)
- [Cryptology ePrint Archive](http://eprint.iacr.org)
- [eBACS: ECRYPT Benchmarking of Cryptographic Systems](http://bench.cr.yp.to)
- [eHash Wiki](http://ehash.iaik.tugraz.at/wiki/The_eHash_Main_Page)
  - [Hash Function Zoo](http://ehash.iaik.tugraz.at/wiki/The_Hash_Function_Zoo)
  - [SHA-3 Zoo](http://ehash.iaik.tugraz.at/wiki/The_SHA-3_Zoo)
- [IACR Conferences (Crypto, Eurocrypt, Asiacrypt)](http://www.iacr.org/conferences/)
- [IEEE Symposium on Security and Privacy (There are loads of papers and talks on YouTube under Program of past events)](https://www.ieee-security.org/TC/SP2017/past.html)
- [Crypto Stack Exchange](https://crypto.stackexchange.com)
- [Blogpost: so-you-want-to-crypto](https://www.seancassidy.me/so-you-want-to-crypto.html)
- [Authenticated Encryption Zoo](https://aezoo.compute.dtu.dk/doku.php?id=AE%20Zoo)
- [Helger Lipmaa Cryptology Pointers](http://kodu.ut.ee/~lipmaa/crypto/)
- [Free Course: Applied Cryptography](https://www.udacity.com/course/applied-cryptography--cs387)
- [Kerckhoffs's principle](https://en.wikipedia.org/wiki/Kerckhoffs%27s_principle)
- [Schneier's Law](https://www.schneier.com/blog/archives/2011/04/schneiers_law.html)
- [crypto blogs from David Wong's github](https://github.com/mimoo/crypto_blogs)

### Textbooks and Lecture Notes

- [Textbook: An Introduction to Mathematical Cryptography](http://citeseerx.ist.psu.edu/viewdoc/download;jsessionid=5F72903FBACA6DF57799612526CC437F?doi=10.1.1.182.9999&rep=rep1&type=pdf)
- [Handbook of Applied Cryptography](http://cacr.uwaterloo.ca/hac/)
- [Goldreich: The Foundations of Cryptography](http://www.wisdom.weizmann.ac.il/%7Eoded/foc-drafts.html)
- [Handbook of Elliptic and Hyperelliptic Curve Cryptography](http://www.hyperelliptic.org/HEHCC/)
- [Mihir Bellare and Shafi Goldwasser's Lecture Notes](http://cseweb.ucsd.edu/%7Emihir/papers/gb.pdf)
- [Charm: A tool for rapid cryptographic prototyping](http://www.charm-crypto.com/index.html)

### Quantum Cryptography

- [Shor in Haskell: The Quantum IO Monad](http://www.cs.nott.ac.uk/%7Epsztxa/publ/qio.pdf)
- [The Quipper Language: programming language for quantum computing](http://www.mathstat.dal.ca/%7Eselinger/quipper/)



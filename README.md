# Slevomat CS - Jan Kaše

Řešení je postavené na design patternu VIPER. Oproti zadání jsem nepoužil Core Data, ale ORM Realm. Core Data již delší dobu nepoužívám, protože je ve srovnání s Realm velmi těžkopádný a navíc Realm umožňuje elegantnější řešení při synchronizaci přístupu z více vláken.

Součástí kodu je rovněž přiložený jeden zdroják, který jsem si vytvořil dříve a mám ho jako samostatnou knihovnu, ale ta podporuje pouze Carthage dependency management a nechtěl jsem tyto dva dependency managery míchat a proto jsem vložil příslušnou třídu přímo do projektu.

Omezení projektu:

- Aplikace v tuto chvíli nijak neřeší nedostupnost síťového připojení při prvním spuštění.
- Webový prohlížeč neřeší žádným způsobem navigaci v rámci webu + neumožňuje přepínání do reader modu apod. 
- Webový prohlížeč nezobrazuje žádný loading indikátor ve chvíli načítání webové stránky.
 
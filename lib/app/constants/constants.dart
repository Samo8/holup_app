import 'package:flutter/material.dart';
import 'package:holup/app/models/automatic_event.dart';
import 'package:holup/app/models/automatic_event_item.dart';

abstract class Constants {
  static const primaryColor = Color(0xFF35C3B3);

  static const regions = [
    'Banskobystrický kraj',
    'Bratislavský kraj',
    'Košický kraj',
    'Nitrianský kraj',
    'Prešovský kraj',
    'Trenčianský kraj',
    'Trnavský kraj',
  ];
  static const districts = [
    'Bánovce nad Bebravou',
    'Banská Bystrica',
    'Banská Štiavnica',
    'Bardejov',
    'Bratislava I',
    'Bratislava II',
    'Bratislava III',
    'Bratislava IV',
    'Bratislava V',
    'Brezno',
    'Bytča',
    'Čadca',
    'Detva',
    'Dolný Kubín',
    'Dunajská Streda',
    'Galanta',
    'Gelnica',
    'Hlohovec',
    'Humenné',
    'Ilava',
    'Kežmarok',
    'Komárno',
    'Košice I',
    'Košice II',
    'Košice III',
    'Košice IV',
    'Košice-okolie',
    'Krupina',
    'Kysucké Nové Mesto',
    'Levice',
    'Levoča',
    'Liptovský Mikuláš',
    'Lučenec',
    'Malacky',
    'Martin',
    'Medzilaborce',
    'Michalovce',
    'Myjava',
    'Námestovo',
    'Nitra',
    'Nové Mesto nad Váhom',
    'Nové Zámky',
    'Partizánske',
    'Pezinok',
    'Piešťany',
    'Poltár',
    'Poprad',
    'Považská Bystrica',
    'Prešov',
    'Prievidza',
    'Púchov',
    'Revúca',
    'Rimavská Sobota',
    'Rožňava',
    'Ružomberok',
    'Sabinov',
    'Senec',
    'Senica',
    'Skalica',
    'Snina',
    'Sobrance',
    'Spišská Nová Ves',
    'Stará Ľubovňa',
    'Stropkov',
    'Svidník',
    'Šaľa',
    'Topoľčany',
    'Trebišov',
    'Trenčín',
    'Trnava',
    'Turčianske Teplice',
    'Tvrdošín',
    'Veľký Krtíš',
    'Vranov nad Topľou',
    'Zlaté Moravce',
    'Zvolen',
    'Žarnovica',
    'Žiar nad Hronom',
    'Žilina',
  ];
  static const genders = ['Ženy', 'Muži'];
  static const ages = [
    'Od 18 do 26 rokov',
    'Od 27 do 50 rokov',
    'Nad 51 rokov',
  ];
  static const types = ['Domov na pol ceste', 'Nocľaháreň', 'Útulok'];

  static const automaticEventResocial = AutomaticEvent(
    title: 'Resocializačný príspevok (RP)',
    type: AutomaticEventType.RESOCIAL,
    items: [
      AutomaticEventItem(
        title: 'Komu sa môže poskytnúť?',
        content: [
          'mladistvému alebo PFO s trvalým pobytom na území SR po jeho prepustení z VTOS, VV alebo ochranného ústavného liečenia, ak ich vykonal na území SR,',
          'cudzincovi s trvalým pobytom na území SR po jeho prepustení z VTOS, VV alebo ochranného ústavného liečenia,',
          'občanovi SR s trvalým pobytom na území SR, ak VTOS, VV, ochrannú výchovu alebo ochranné ústavné liečenie vykonal preukázateľne mimo územia SR, a to po jeho návrate na územie SR.',
        ],
      ),
      AutomaticEventItem(
        title: 'Podmienky poskytnutia RP',
        content: [
          'prepustenie mladistvého alebo plnoletého občana z VTOS, VV, skončenie ochrannej výchovy alebo ochranného ústavného liečenia,',
          'VTOS, VV, ochranná výchova alebo ochranné ústavné liečenie trvalo viac ako 30 po sebe nasledujúcich dní,',
          'uchádza sa o pomoc orgánu sociálnoprávnej ochrany detí a sociálnej kurately (SPODaSK) v mieste obvyklého '
              'pobytu pri začlenení do života do 8 pracovných dní odo dňa prepustenia z VTOS, VV, skončenia ochrannej výchovy alebo ochranného ústavného liečenia,',
          'existuje reálna potreba priznania resocializačného príspevku, ktorý uľahčí resocializáciu mladistvého alebo plnoletej fyzickej osoby.',
        ],
      ),
      AutomaticEventItem(
        title: 'Resocializačný príspevok sa neposkytuje:',
        content: [
          'maloletému bez sprievodu alebo cudzincovi, ktorý nemá trvalý pobyt na území SR,',
          'pri prerušení VTOS, VV, pri prerušení ochrannej výchovy alebo ochranného ústavného liečenia.',
        ],
      ),
      AutomaticEventItem(
        title: 'Výška resocializačného príspevku:',
        content: [
          'najviac vo výške 40 % sumy životného minima pre jednu plnoletú fyzickú osobu. '
              '(napr. od 01.07.2018 je životné minimum pre jednu PFO 205,07 EUR, potom 205,07 x 0,40 = 82,028 EUR je výška resocializačného príspevku),',
          'resocializačný príspevok je možné poskytnúť vpeňažnej, vecnej alebo kombinovanej forme.',
        ],
      ),
    ],
  );

  static const automaticEventWorkOffice = AutomaticEvent(
    title: 'Evidencia na úrade práce',
    type: AutomaticEventType.WORK_OFFICE,
    items: [
      AutomaticEventItem(
        title: 'Evidencia na úrade práce je dobrovoľná, ALE:',
        content: [
          'Zdravotné poistenie počas evidencie nezamestnaného na úrade práce platí štát. V prípade, že nie ste evidovaný na úrade práce, musíte si zdravotné poistenie platiť sám',
          'Ak si chcete uplatniť dávku v hmotnej núdzi, musíte sa zaevidovať na úrade práce ako uchádzač o zamestnanie.',
          'Zaradenie do evidencie nezamestnaných na UPSVR je potrebné požiadať do 7 kalendárnych dní od prepustenia z výkonu trestu.',
          'Ak sa zaevidujete po 7 dňoch, tak budete evidovaný dňom zaevidovania. V takom prípade si musíte za tieto dni doplatiť zdravotné poistenie.',
        ],
      ),
      AutomaticEventItem(
        title:
            'V prípade, že sa zaevidujete ako uchádzač o zamestnanie (nezamestnaný) na Oddelení poradenstva a vzdelávania, máte možnosť:',
        content: [
          'zúčastňovať sa individuálnych a skupinových poradenských aktivít v klube práce, kde si môžete bezplatne vyhľadávať voľné pracovné miesta na internete, napísať žiadosť do zamestnania, profesionálny životopis a iné.',
          'zúčastniť sa rekvalifikačných kurzov cez REPAS a KOMPAS.',
        ],
      ),
      AutomaticEventItem(
        title: 'Uchádzač o zamestnanie má aj povinnosti:',
        content: [
          'Ak neplníte povinnosti, nespolupracujete, vykonávate nelegálnu prácu (tzv. práca na čierno), nedostavíte sa na dohodnutý termín bez ospravedlnenia, budete z evidencie úradu práce vyradený/á na dobu 6 mesiacov.',
          'Odporúčame vám ospravedlniť sa v prípade choroby najlepšie telefonicky a následne do 3 dní zašlite (doručte) lekárom vystavený doklad o pracovnej neschopnosti.',
          'Uchádzač o zamestnanie môže pracovať na dohodu maximálne 40 kalendárnych dní v roku a môže mať len jednu dohodu, nie súčasne viac dohôd. Mesačný príjem musí byť maximálne vo výške životného minima.',
        ],
      ),
    ],
  );

  static const automaticEvents = [
    automaticEventResocial,
    automaticEventWorkOffice
  ];

  static const automaticEventsImportMaxDuration = Duration(days: 10);
}

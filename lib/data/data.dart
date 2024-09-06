// pest_descriptions.dart

class PestInfo {
  final String name;
  final String information;
  final String solution;
  final String imagePath;

  PestInfo({
    required this.name,
    required this.information,
    required this.solution,
    required this.imagePath,
  });
}

class PestDescriptions {
  static final Map<String, PestInfo> pests = {
    'Wasp': PestInfo(
      name: 'Gagamba',
      information:
          'Ang mga gagamba ay mga lumilipad na insekto na may payat na katawan at makitid na baywang. May papel sila sa polinasyon at pagkontrol ng peste ngunit maaaring maging agresibo kapag nanganganib.',
      solution:
          '1. Alisin ang mga bagay na nag-aakit sa kanila tulad ng bukas na basura. \n2. I-seal ang mga pasukan sa mga gusali. \n3. Gumamit ng mga patibong para sa gagamba. \n4. Para sa matinding pagsalakay, isaalang-alang ang propesyonal na kontrol ng peste.',
      imagePath: 'assets/images/pest/wasp.jpg',
    ),
    'Weevil': PestInfo(
      name: 'Weevil',
      information:
          'Ang mga weevil ay maliliit na beetle na may mahahabang pangil. Maaari nilang salakayin ang mga nakaimbak na butil at iba pang tuyong kalakal.',
      solution:
          '1. Suriin at itapon ang mga infested na pagkain. \n2. Linisin ng mabuti ang mga lugar ng imbakan. \n3. Itago ang pagkain sa mga airtight na lalagyan. \n4. Gumamit ng bay leaves o diatomaceous earth bilang natural na pang-iwas.',
      imagePath: 'assets/images/pest/weevil.jpg',
    ),
    'Snail': PestInfo(
      name: 'Suso',
      information:
          'Ang mga suso ay mabagal na molusko na maaaring makasira sa mga halaman sa pamamagitan ng pagkain sa mga dahon at tangkay.',
      solution:
          '1. Alisin ang mga suso ng mano-mano. \n2. Gumamit ng copper tape o mga hadlang. \n3. Maglagay ng mga patibong ng beer upang akitin at lunurin ang mga suso.',
      imagePath: 'assets/images/pest/snail.jpg',
    ),
    'Moth': PestInfo(
      name: 'Moth',
      information:
          'Ang mga moth ay maaaring makasira sa mga tela at nakaimbak na produkto, at ang kanilang mga larvae ay kumakain sa iba\'t ibang halaman.',
      solution:
          '1. Gumamit ng mothballs sa mga lugar ng imbakan. \n2. Alisin ang mga infested na halaman. \n3. Mag-set up ng pheromone traps upang mahuli ang mga moth.',
      imagePath: 'assets/images/pest/moth.jpg',
    ),
    'Slug': PestInfo(
      name: 'Slug',
      information:
          'Ang mga slug ay katulad ng mga suso ngunit walang shell. Kumakain sila ng materyal ng halaman at maaaring magdulot ng malawak na pinsala.',
      solution:
          '1. Gumamit ng slug pellets o patibong. \n2. Gumawa ng mga hadlang gamit ang pinatuyong egg shells o diatomaceous earth. \n3. Magdilig ng mga halaman sa umaga upang mabawasan ang kahalumigmigan sa gabi.',
      imagePath: 'assets/images/pest/slug.jpg',
    ),
    'Earwig': PestInfo(
      name: 'Earwig',
      information:
          'Ang mga earwig ay nocturnal na insekto na kumakain sa mga halaman at nabubulok na organikong bagay.',
      solution:
          '1. Gumamit ng mga patibong mula sa mamasa-masang nakatiklop na diyaryo. \n2. Alisin ang mga labi at patay na materyal ng halaman. \n3. Mag-apply ng insecticidal soap.',
      imagePath: 'assets/images/pest/earwig.jpg',
    ),
    'Grasshopper': PestInfo(
      name: 'Salagubang',
      information:
          'Ang mga salagubang ay mga insekto na kumakain ng halaman na maaaring magdulot ng malubhang pinsala sa mga tanim at hardin.',
      solution:
          '1. Gumamit ng insecticidal sprays. \n2. Magpakilala ng mga natural na mandaragit tulad ng mga ibon. \n3. Mag-apply ng neem oil sa mga halaman.',
      imagePath: 'assets/images/pest/grasshopper.jpg',
    ),
    'Caterpillar': PestInfo(
      name: 'Caterpillar',
      information:
          'Ang mga caterpillar ay larvae ng mga paru-paro at moth. Maaari nilang ubusin ang mga dahon ng halaman at magdulot ng pinsala.',
      solution:
          '1. Alisin ang mga caterpillar mula sa mga halaman ng mano-mano. \n2. Gumamit ng Bacillus thuringiensis (Bt) bilang natural na insecticide. \n3. Himukin ang mga natural na mandaragit tulad ng mga ibon.',
      imagePath: 'assets/images/pest/caterpillar.jpg',
    ),
    'Earthworm': PestInfo(
      name: 'Laway',
      information:
          'Ang mga earthworm ay kapaki-pakinabang para sa kalusugan ng lupa dahil tumutulong silang mag-aerate ng lupa at mag-decompose ng organikong materyal.',
      solution:
          'Walang kinakailangang aksyon dahil ang mga earthworm ay kapaki-pakinabang para sa kalusugan ng lupa.',
      imagePath: 'assets/images/pest/earthworms.jpg',
    ),
    'Beetle': PestInfo(
      name: 'Beetle',
      information:
          'Ang mga beetle ay karaniwang insekto na maaaring makasira sa mga tanim sa pamamagitan ng pagkain sa mga dahon, tangkay, at ugat.',
      solution:
          '1. Alisin ang mga beetle mula sa mga halaman ng mano-mano. \n2. Gumamit ng insecticidal soap o neem oil. \n3. Mag-rotate ng mga tanim upang mabawasan ang populasyon ng beetle.',
      imagePath: 'assets/images/pest/beetle.jpg',
    ),
    'Ants': PestInfo(
      name: 'Langgam',
      information:
          'Ang mga langgam ay sosyal na insekto na maaaring magdulot ng abala sa pamamagitan ng pagpasok sa mga tahanan para sa pagkain.',
      solution:
          '1. I-seal ang mga pasukan sa mga gusali. \n2. Gumamit ng ant baits o patibong. \n3. Itago ang pagkain sa mga airtight na lalagyan.',
      imagePath: 'assets/images/pest/ants.jpg',
    ),
    'Bees': PestInfo(
      name: 'Bubuyog',
      information:
          'Ang mga bubuyog ay mahalagang pollinators, ngunit ang ilang species ay maaaring maging agresibo kapag ang kanilang mga pugad ay naabala.',
      solution:
          '1. Iwasang abalahin ang mga pugad ng bubuyog. \n2. Makipag-ugnayan sa mga propesyonal na beekeepers para sa ligtas na pagtanggal kung kinakailangan.',
      imagePath: 'assets/images/pest/bees.jpg',
    ),
    'Borers': PestInfo(
      name: 'Borers',
      information:
          'Ang mga borer ay mga larvae na sumusubok na pumasok sa mga puno at halaman, na nagiging sanhi ng malubhang pinsala.',
      solution:
          '1. I-prune at sirain ang mga infested na sanga. \n2. Gumamit ng insecticides upang targetin ang mga larvae. \n3. Panatilihin ang kalusugan ng halaman upang labanan ang mga borer.',
      imagePath: 'assets/images/pest/borers.jpg',
    ),
    'Cane Grubs': PestInfo(
      name: 'Cane Grubs',
      information:
          'Ang mga cane grubs ay larvae ng beetles na kumakain sa ugat ng tubo, na nagiging sanhi ng pagbawas sa ani.',
      solution:
          '1. Mag-apply ng soil insecticides. \n2. Mag-rotate ng mga tanim upang masira ang siklo ng buhay. \n3. Subaybayan ang mga larangan para sa presensya ng grubs.',
      imagePath: 'assets/images/pest/cane_grubs.jpg',
    ),
    'Corn Earworm': PestInfo(
      name: 'Corn Earworm',
      information:
          'Ang mga corn earworms ay caterpillar na kumakain sa mga tenga ng mais, na nagbabawas sa kalidad ng ani.',
      solution:
          '1. Gumamit ng insecticidal sprays. \n2. Magtanim ng mga uri ng mais na lumalaban. \n3. Gumamit ng pheromone traps upang subaybayan ang populasyon.',
      imagePath: 'assets/images/pest/corn_earworm.jpg',
    ),
    'Corn Leaf Aphid': PestInfo(
      name: 'Corn Leaf Aphid',
      information:
          'Ang mga corn leaf aphids ay sumususo ng katas mula sa mga halaman ng mais, na nagiging sanhi ng pagbagal ng paglago at pagbawas ng ani.',
      solution:
          '1. Gumamit ng insecticidal soap o neem oil. \n2. Himukin ang mga natural na mandaragit tulad ng ladybugs. \n3. Mag-apply ng horticultural oil upang takpan ang mga aphid.',
      imagePath: 'assets/images/pest/corn_leaf_aphid.jpg',
    ),
    'Cutworms': PestInfo(
      name: 'Cutworms',
      information:
          'Ang mga cutworms ay caterpillar na kumakain sa mga tangkay ng mga batang halaman, madalas na pinutol ang mga ito sa base.',
      solution:
          '1. Gumamit ng mga cardboard collars sa paligid ng mga tangkay ng halaman. \n2. Mag-apply ng mga beneficial nematodes sa lupa. \n3. Alisin ang mga labi ng halaman kung saan nagtatago ang mga cutworms.',
      imagePath: 'assets/images/pest/cutworms.jpg',
    ),
    'Early Shoot Borer': PestInfo(
      name: 'Early Shoot Borer',
      information:
          'Ang mga early shoot borers ay umaatake sa mga batang shoots ng tubo, na nagiging sanhi ng pagbawas sa ani.',
      solution:
          '1. Gumamit ng insecticidal sprays. \n2. Alisin at sirain ang mga infested na shoots. \n3. Mag-apply ng biological controls tulad ng parasitic wasps.',
      imagePath: 'assets/images/pest/early_shoot_borer.jpg',
    ),
    'Fall Armyworm': PestInfo(
      name: 'Fall Armyworm',
      information:
          'Ang mga fall armyworms ay caterpillar na maaaring makasira sa mga tanim tulad ng mais, cotton, at gulay sa pamamagitan ng pagkain sa mga dahon at tangkay.',
      solution:
          '1. Gumamit ng insecticidal sprays o Bacillus thuringiensis (Bt). \n2. Mag-rotate ng mga tanim upang mabawasan ang pagsalakay. \n3. Subaybayan ang mga larangan nang regular para sa mga maagang senyales ng pagsalakay.',
      imagePath: 'assets/images/pest/fall_armyworm.jpg',
    ),
    'Undefined': PestInfo(
      name: 'Hindi Tukoy',
      information:
          'Ang peste ay hindi maaring matukoy. Mangyaring tiyakin na malinaw ang larawan at maayos ang pokus sa insekto.',
      solution:
          'Subukan ang kumuha ng ibang larawan na may mas magandang ilaw at pokus. Kung magpapatuloy ang problema, kumonsulta sa lokal na eksperto sa kontrol ng peste para sa personal na pagtukoy.',
      imagePath: 'assets/images/pest/undefined.jpg',
    ),
  };

  static PestInfo getPestInfo(String pest) {
    return pests[pest.trim()] ?? pests['Undefined']!;
  }
}

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Rapide",
    image: "assets/onboarding/rapide.png",
    //desc: "Trouver votre ouvrier professionnel, disponible et crédible en quelques clics.",
    desc: "Trouvez rapidement des experts pour vos besoins en un clic.",
  ),
  OnboardingContents(
    title: "Simple",
    image: "assets/onboarding/simple.png",
    //desc: "Une interface simple et intuitive pour une utilisation sans effort.",
    desc:  "Une interface conviviale pour une utilisation sans effort.",
  ),
  OnboardingContents(
    title: "fiable",
    image: "assets/onboarding/fiable.png",
    //desc: "Connexion directe, pas d'intermédiaire ni de frais cachés, fiabilité garantie.",
    desc: "Des prestataires de services de confiance à votre service.",

  ),
];
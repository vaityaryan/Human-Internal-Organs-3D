import 'package:flutter/material.dart';
import 'package:flutter_application_1/splash_screen.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return _buildGridItem(
              context,
              index == 0 ? 'assets/images/heart.png' :
              index == 1 ? 'assets/images/brain.png' :
              index == 2 ? 'assets/images/lung.jpg' :
              'assets/images/pancreas.jpg', // Lungs and Pancreas

              index == 0 ? 'Heart' :
              index == 1 ? 'Brain' :
              index == 2 ? 'Lungs' :
              'Pancreas',

              index == 0 ? const HeartScreen() :
              index == 1 ? const BrainScreen() :
              index == 2 ? const LungScreen() :
              const PancreasScreen(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String imagePath, String label, Widget screen) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imagePath, height: 120, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}

class HeartScreen extends StatelessWidget {
  const HeartScreen({super.key});

  final List<Map<String, String>> heartParts = const [
    {
    'name': 'Aorta',
    'image': 'assets/images/Aorta.png',
    'model': 'assets/images/Aorta-model.glb',
    'description': 'The aorta is the largest artery in the human body. It carries oxygen-rich blood from the heart’s left ventricle to the entire body. It has three main sections: the ascending aorta, the aortic arch, and the descending aorta. The ascending aorta gives rise to the coronary arteries, which supply blood to the heart itself. The aortic arch has branches supplying the head and arms. The descending aorta delivers blood to the lower body. It plays a crucial role in systemic circulation, ensuring organs receive oxygenated blood.'
  },
  {
    'name': 'Ventricle',
    'image': 'assets/images/Ventricle.jpg',
    'model': 'assets/images/Ventricle-model.glb',
    'description': 'The ventricles are the lower chambers of the heart that pump blood throughout the body. The right ventricle pumps deoxygenated blood to the lungs via the pulmonary artery. The left ventricle pumps oxygen-rich blood to the entire body through the aorta. The left ventricle has a thicker muscular wall since it needs to generate high pressure to circulate blood. Ventricular contraction is a key step in the heartbeat cycle. Any damage to the ventricles can lead to serious heart conditions like heart failure.'
  },
  {
    'name': 'Atrium',
    'image': 'assets/images/Atrium.jpg',
    'model': 'assets/images/Atrium-model.glb',
    'description': 'The atria are the two upper chambers of the heart that receive blood returning to the heart. The right atrium collects deoxygenated blood from the body via the superior and inferior vena cava. The left atrium receives oxygenated blood from the lungs through the pulmonary veins. The atria push blood into the ventricles before contraction. They help regulate heart rhythm and blood flow efficiency. The atria have thinner walls compared to the ventricles since they don’t generate as much pressure. Conditions like atrial fibrillation can cause irregular heartbeats.'
  },
  {
    'name': 'Superior Vena Cava',
    'image': 'assets/images/SVC.jpg',
    'model': 'assets/images/SVC-model.glb',
    'description': 'The superior vena cava is a large vein that returns deoxygenated blood from the upper body to the heart. It collects blood from the head, neck, arms, and upper chest and directs it into the right atrium. Unlike arteries, veins have thinner walls and lower pressure. Blockage or compression of the superior vena cava can lead to a condition called "superior vena cava syndrome," causing swelling in the face and arms. It works together with the inferior vena cava to complete systemic venous return. This vein is critical for circulation and oxygen exchange in the lungs.'
  },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Heart 3D Model'),backgroundColor: const Color(0xFF3D0606),foregroundColor: Colors.white,),
      body: Column(
        children: [
          // Wrap ModelViewer in SizedBox to avoid infinite constraints
          SizedBox(
            height: 350, // Fixed height to prevent layout errors
            child: ModelViewer(
              src: 'assets/images/heart-model.glb',
              alt: '3D Model of heart',
              ar: true ,
              autoRotate: true,
              cameraControls: true, // User can manually control rotation
              backgroundColor: const Color(0xFFFFE3CF), // Better UI contrast
            ),
          ),
          const SizedBox(height: 20), // Space between 3D model and grid
          Expanded(
            child: Padding(
               
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: heartParts.length,
                itemBuilder: (context, index) {
                  final part = heartParts[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(part: part),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: 2),
                            image: DecorationImage(
                              image: AssetImage(part['image']!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          part['name']!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class DetailScreen extends StatefulWidget {
  final Map<String, String> part;

  const DetailScreen({super.key, required this.part});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  bool isPlaying = false; // Controls icon state

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _toggleSpeech() async {
    if (isPlaying) {
      await _flutterTts.stop();
      setState(() => isPlaying = false);
    } else {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1.2);
      await _flutterTts.speak(widget.part['description']!);
      await _flutterTts.setSpeechRate(0.5);  // Slower speech
      await _flutterTts.setVolume(1.0);
      setState(() => isPlaying = true);

      // Detect when speech finishes
      _flutterTts.setCompletionHandler(() {
        setState(() => isPlaying = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.part['name']!)),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 3D Model Viewer
                SizedBox(
                  height: 300,
                  child: ModelViewer(
                    src: widget.part['model']!,
                    alt: '3D Model of ${widget.part['name']}',
                    ar: true,
                    autoRotate: true,
                    backgroundColor: const Color(0xFFFFE3CF),
                  ),
                ),
                const SizedBox(height: 20),

                // Description Box
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      widget.part['description']!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 80), // Space for floating button
              ],
            ),
          ),

          // Floating TTS Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _toggleSpeech,
              backgroundColor: const Color(0xFFFFE3CF),
              child: Icon(isPlaying ? Icons.pause : Icons.volume_up, size: 35, color: const Color(0xFF3D0606),),
            ),
          ),
        ],
      ),
    );
  }
}

class BrainScreen extends StatelessWidget {
  const BrainScreen({super.key});

  final List<Map<String, String>> brainParts = const [
    {
      'name': 'Brain Stem',
      'image': 'assets/images/brainstem.jpg',
      'model': 'assets/images/brain-stem.glb',
      'description': 'Located at the base of the brain, the brainstem connects the cerebrum and cerebellum to the spinal cord. It acts as a relay center and manages many automatic functions essential for survival. The brainstem is divided into three main parts:\n 1) Midbrain: Involved in functions such as vision, hearing, eye movement, and body movement.\n 2) Pons: Serves as a bridge between various parts of the nervous system, including the cerebrum and cerebellum. It plays a role in motor control and sensory analysis.\n 3) Medulla Oblongata: Regulates vital functions like heart rate, breathing, blood vessel dilation, digestion, sneezing, swallowing, and vomiting. '
    },
    {
      'name': 'Cerebellum',
      'image': 'assets/images/braincerebellum.jpg',
      'model': 'assets/images/brain-cerebellum.glb',
      'description': 'The cerebellum is a part of the brain located at the back of the head, beneath the occipital lobe and above the brainstem. It is responsible for coordinating voluntary movements, balance, posture, and motor learning. Despite its smaller size compared to other brain regions, the cerebellum contains more than half of the brain’s neurons, making it crucial for precise motor control and cognitive functions.\n\n 1) Motor Coordination:Ensures smooth and precise movements by integrating sensory inputs and motor commands.\n 2) Balance and Posture:Helps maintain equilibrium and upright posture by processing signals from the inner ear and muscles.\n 3) Motor Learning:Plays a key role in learning new motor skills, such as riding a bike or playing an instrument.\n 4) Cognitive and Language Processing:Contributes to cognitive tasks, language comprehension, and problem-solving abilities.'
    },
    {
      'name': 'Lobes',
      'image': 'assets/images/brainlobe.jpg',
      'model': 'assets/images/brain-lobe.glb',
      'description': 'The brain has different lobes: frontal, parietal, temporal, and occipital. Each controls different functions like thinking, sensation, and vision.\n\n- Controls reasoning, planning, and problem-solving.\n- Manages voluntary movement and coordination.\n- Regulates emotions and personality.\n- Plays a role in speech production.\n- Involved in decision-making and impulse control.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brain 3D Model'),backgroundColor:const Color(0xFF3D0606),foregroundColor: Colors.white,),
      body: Column(
        children: [
          SizedBox(
            height: 350, // Fixed height for the 3D model
            child: ModelViewer(
              src: 'assets/images/brain-model.glb', // Main brain 3D model
              alt: '3D Model of Brain',
              ar: true,
              autoRotate: true,
              cameraControls: true,
              backgroundColor: const Color(0xFFFFE3CF),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: brainParts.length,
                itemBuilder: (context, index) {
                  final part = brainParts[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrainDetailScreen(brainPart: part),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: 2),
                            image: DecorationImage(
                              image: AssetImage(part['image']!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          part['name']!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class BrainDetailScreen extends StatefulWidget {
  final Map<String, String> brainPart;

  const BrainDetailScreen({super.key, required this.brainPart});

  @override
  _BrainDetailScreenState createState() => _BrainDetailScreenState();
}

class _BrainDetailScreenState extends State<BrainDetailScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  bool isPlaying = false; // Controls icon state

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _toggleSpeech() async {
    if (isPlaying) {
      await _flutterTts.stop();
      setState(() => isPlaying = false);
    } else {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1.2);
      await _flutterTts.setSpeechRate(0.5); // Slower speech
      await _flutterTts.setVolume(1.0);
      await _flutterTts.speak(widget.brainPart['description']!);
      setState(() => isPlaying = true);

      // Detect when speech finishes
      _flutterTts.setCompletionHandler(() {
        setState(() => isPlaying = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.brainPart['name']!)),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 3D Model Viewer
                SizedBox(
                  height: 300,
                  child: ModelViewer(
                    src: widget.brainPart['model']!,
                    alt: '3D Model of ${widget.brainPart['name']}',
                    ar: true,
                    autoRotate: true,
                    backgroundColor: const Color(0xFFFFE3CF),
                  ),
                ),
                const SizedBox(height: 10),

                // Description Box
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      widget.brainPart['description']!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 80), // Space for floating button
              ],
            ),
          ),

          // Floating TTS Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _toggleSpeech,
              backgroundColor: const Color(0xFFFFE3CF),
              child: Icon(isPlaying ? Icons.pause : Icons.volume_up, size: 30,color:const Color(0xFF3D0606)),
            ),
          ),
        ],
      ),
    );
  }
}

class LungScreen extends StatelessWidget {
  const LungScreen({super.key});

  final List<Map<String, String>> lungParts = const [
    {
      'name': 'Left Lung',
      'image': 'assets/images/leftlung.jpg',
      'model': 'assets/images/lung-leftandright.glb',
      'description': '1) Size & Shape: The left lung is slightly smaller than the right lung because it shares space with the heart. It has two lobes:\n (i)Superior Lobe – The upper section of the left lung.\n(ii)Inferior Lobe – The lower section of the left lung.\n2) Cardiac Notch: A depression in the left lung that accommodates the heart.\n3) Lingula: A small tongue-like projection of the superior lobe that functions similarly to the middle lobe in the right lung.\n4) Functions: It helps in gas exchange, allowing oxygen to enter the bloodstream while expelling carbon dioxide.'
    },
    {
      'name': 'Right Lung',
      'image': 'assets/images/rightlung.jpg',
      'model': 'assets/images/lung-leftandright.glb',
      'description': '1) Size & Shape: The right lung is larger and broader than the left lung and consists of three lobes:\n(i)Superior Lobe – The uppermost part.\n(ii)Middle Lobe – Not present in the left lung.\n(iii)Inferior Lobe – The lower section.\n2) Oblique & Horizontal Fissures: These fissures separate the lobes of the right lung.\n3) Functions: Similar to the left lung, it facilitates oxygen absorption and carbon dioxide expulsion. Because of its size, it handles a slightly larger volume of air.'
    },
    {
      'name': 'Trachea',
      'image': 'assets/images/lung-trachea.jpg',
      'model': 'assets/images/lung-trachea.glb',
      'description': '1) Structure: A flexible, tube-like structure made of C-shaped cartilage rings that prevent it from collapsing while allowing flexibility.\n2) Functions: Serves as an airway passage that connects the larynx (voice box) to the lungs, allowing the passage of oxygen into the lungs and carbon dioxide out.\n3) Bifurcation (Carina): The trachea splits into the left and right bronchi, leading to each lung.\n4) Lining: Covered with mucus and tiny hair-like structures called cilia that help filter dust, bacteria, and pollutants before they reach the lungs.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lungs 3D Model'), backgroundColor: const Color(0xFF3D0606), foregroundColor: Colors.white),
      body: Column(
        children: [
          SizedBox(
            height: 350,
            child: ModelViewer(
              src: 'assets/images/lung-model.glb',
              alt: '3D Model of Lungs',
              ar: true,
              autoRotate: true,
              cameraControls: true,
              backgroundColor: const Color(0xFFFFE3CF),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: lungParts.length,
                itemBuilder: (context, index) {
                  final part = lungParts[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LungDetailScreen(lungPart: part),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: 2),
                            image: DecorationImage(
                              image: AssetImage(part['image']!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          part['name']!,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LungDetailScreen extends StatefulWidget {
  final Map<String, String> lungPart;
  const LungDetailScreen({super.key, required this.lungPart});

  @override
  _LungDetailScreenState createState() => _LungDetailScreenState();
}

class _LungDetailScreenState extends State<LungDetailScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  bool isPlaying = false;

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _toggleSpeech() async {
    if (isPlaying) {
      await _flutterTts.stop();
      setState(() => isPlaying = false);
    } else {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1.2);
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.speak(widget.lungPart['description']!);
      setState(() => isPlaying = true);

      _flutterTts.setCompletionHandler(() {
        setState(() => isPlaying = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.lungPart['name']!)),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  child: ModelViewer(
                    src: widget.lungPart['model']!,
                    alt: '3D Model of ${widget.lungPart['name']}',
                    ar: true,
                    autoRotate: true,
                    backgroundColor: const Color(0xFFFFE3CF),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      widget.lungPart['description']!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _toggleSpeech,
              backgroundColor: const Color(0xFFFFE3CF),
              child: Icon(isPlaying ? Icons.pause : Icons.volume_up, size: 30, color: const Color(0xFF3D0606)),
            ),
          ),
        ],
      ),
    );
  }
}

class PancreasScreen extends StatelessWidget {
  const PancreasScreen({super.key});

  final List<Map<String, String>> pancreasParts = const [
    {
      'name': 'Pancreas',
      'image': 'assets/images/pancreas-main.jpg',
      'model': 'assets/images/pancreas-main.glb',
      'description': '1) Function: The pancreas plays a crucial role in digestion and blood sugar regulation. It produces digestive enzymes and insulin.2) Structure: It consists of three main parts:(i) Head – The widest part, located near the small intestine.(ii) Body – The central part.(iii) Tail – The narrowest end, extending towards the spleen.'
    },
    {
      'name': 'Gallbladder',
      'image': 'assets/images/gallblader.jpg',
      'model': 'assets/images/pancreas-gallblader.glb',
      'description': '1) Function: Stores and releases bile, which helps in fat digestion.2) Location: Positioned beneath the liver and connected to the bile ducts.'
    },
    {
      'name': 'Spleen',
      'image': 'assets/images/spleen.jpg',
      'model': 'assets/images/pancreas-spleen.glb',
      'description': '1) Function: Filters blood, recycles old red blood cells, and supports the immune system.2) Location: Found in the upper left abdomen, near the stomach and pancreas.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pancreas 3D Model'), backgroundColor: const Color(0xFF3D0606), foregroundColor: Colors.white),
      body: Column(
        children: [
          SizedBox(
            height: 350,
            child: ModelViewer(
              src: 'assets/images/pancreas-model.glb',
              alt: '3D Model of Pancreas',
              ar: true,
              autoRotate: true,
              cameraControls: true,
              backgroundColor: const Color(0xFFFFE3CF),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: pancreasParts.length,
                itemBuilder: (context, index) {
                  final part = pancreasParts[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PancreasDetailScreen(pancreasPart: part),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: 2),
                            image: DecorationImage(
                              image: AssetImage(part['image']!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          part['name']!,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PancreasDetailScreen extends StatefulWidget {
  final Map<String, String> pancreasPart;
  const PancreasDetailScreen({super.key, required this.pancreasPart});

  @override
  _PancreasDetailScreenState createState() => _PancreasDetailScreenState();
}

class _PancreasDetailScreenState extends State<PancreasDetailScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  bool isPlaying = false;

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _toggleSpeech() async {
    if (isPlaying) {
      await _flutterTts.stop();
      setState(() => isPlaying = false);
    } else {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1.2);
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.speak(widget.pancreasPart['description']!);
      setState(() => isPlaying = true);

      _flutterTts.setCompletionHandler(() {
        setState(() => isPlaying = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pancreasPart['name']!)),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  child: ModelViewer(
                    src: widget.pancreasPart['model']!,
                    alt: '3D Model of ${widget.pancreasPart['name']}',
                    ar: true,
                    autoRotate: true,
                    backgroundColor: const Color(0xFFFFE3CF),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      widget.pancreasPart['description']!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _toggleSpeech,
              backgroundColor: const Color(0xFFFFE3CF),
              child: Icon(isPlaying ? Icons.pause : Icons.volume_up, size: 30, color: const Color(0xFF3D0606)),
            ),
          ),
        ],
      ),
    );
  }
}

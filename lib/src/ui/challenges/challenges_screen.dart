import 'package:flutter/material.dart';
import 'package:health_body_checking/src/models/challenge_model.dart';
import 'package:health_body_checking/src/models/exercise_challenge_model.dart';
import 'package:health_body_checking/src/models/user_model.dart';
import 'package:health_body_checking/src/services/exercise_callenge_service.dart';
import 'package:health_body_checking/src/ui/challenges/exercises_challenge_screen.dart';
import 'package:health_body_checking/src/utils/hex_color.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../constants/app_colors.dart';
import '../../core/routes/routes.dart';
import 'widgets/feeding_challenge_container.dart';

class ChallengesScreen extends StatefulWidget {
  ChallengesScreen({Key key}) : super(key: key);

  @override
  _ChallengesScreenState createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  ExerciseChallengeService _service;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ExerciseChallengeModel _exerciseChallengeModel;
  @override
  void initState() {
    _service = ExerciseChallengeService();
    super.initState();
    _getChallenges();
  }

  _getChallenges() {
    this
        ._service
        .findByUserId(userId: CurrentUserModel.instance.id)
        .listen((event) {
      _exerciseChallengeModel = event[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.ALICE_BLUE,
              elevation: 0.0,
              title: _tabBarHeader(),
            ),
            key: _scaffoldKey,
            body: TabBarView(children: [_exercises(), _feeding()])));
  }

  Widget _tabBarHeader() {
    return TabBar(
        unselectedLabelColor: AppColors.PRIMARY_DARK,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.PRIMARY_DARK),
        tabs: [
          _tabBarHeaderTextContainer(text: 'Actividad fisica'),
          _tabBarHeaderTextContainer(text: 'Alimentacion')
        ]);
  }

  Widget _tabBarHeaderTextContainer({String text}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.PRIMARY_DARK, width: 1)),
      child: Align(
        alignment: Alignment.center,
        child: Text(text),
      ),
    );
  }

  Widget _exercises() {
    return StreamBuilder(
      stream: _service.findByUserId(userId: CurrentUserModel.instance.id),
      builder: (BuildContext context,
          AsyncSnapshot<List<ExerciseChallengeModel>> snapshot) {
        if (snapshot.hasData) {
          _exerciseChallengeModel= snapshot.data[0];
          return ListView.builder(
            itemCount: _exerciseChallengeModel.challenges.length,
            itemBuilder: (BuildContext context, int index) {
              return _challengeCircle(index);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  final CircularSliderAppearance appearance02 = CircularSliderAppearance(
      customWidths: CustomSliderWidths(
          trackWidth: 15, progressBarWidth: 15, shadowWidth: 30),
      customColors: CustomSliderColors(
          dotColor: Colors.white,
          trackColor: HexColor('#9B9B9B'),
          progressBarColor: AppColors.PRIMARY,
          shadowColor: HexColor('#98DBFC'),
          shadowStep: 15.0,
          shadowMaxOpacity: 0.3),
      startAngle: 270,
      angleRange: 360,
      size: 200.0,
      counterClockwise: true,
      animationEnabled: true);
  void _showValidateMessage(String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Icon(Icons.info,color:Colors.yellow,size: 30,),
                SizedBox(height: 2,),
                Text(text,textAlign: TextAlign.center,),
              ],
            ),
            actions: [
              FlatButton(
                color: AppColors.ELECTROMACNETIC,
                child: Row(
                  children: [
                    Icon(
                      Icons.check_box,
                      color: AppColors.PRIMARY,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "Ok",
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  Widget _challengeCircle(int index) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            if((index==0 || _exerciseChallengeModel.challenges[index>0?index-1:0].completed) && _exerciseChallengeModel.challenges[index].completed==false ){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ExercisesChallengeScreen(exerciseChallengeModel: _exerciseChallengeModel,index: index,) ));
            }
            else if(_exerciseChallengeModel.challenges[index].completed){
              _showValidateMessage('Ya completaste este reto');
            }
            else{
              _showValidateMessage('Tiene que completar el reto anterior');
            }
          },
          child: SleekCircularSlider(
              appearance: appearance02,
              min: 0,
              max: _exerciseChallengeModel.challenges[index].days.toDouble(),
              initialValue: _exerciseChallengeModel.challenges[index].currentDay.toDouble(),
              innerWidget: (double value) {
                return Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          color:  _exerciseChallengeModel.challenges[index].completed?AppColors.PRIMARY:HexColor('#9B9B9B'),
                          borderRadius: BorderRadius.circular(150)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _exerciseChallengeModel.challenges[index].completed?Icon(Icons.accessibility,color: AppColors.WHITE,):Icon(Icons.directions_run,color: AppColors.WHITE),
                            Text('${_exerciseChallengeModel.challenges[index].minuts} minutos durante ${_exerciseChallengeModel.challenges[index].days}  dias',textAlign: TextAlign.center,style:TextStyle(color: AppColors.WHITE),)  
                          ],
                        )
                      )
                      )
                    );
              },
            ),
          ),
        (index%2==0)?Image.asset('assets/images/arrow1.png',):Image.asset('assets/images/arrow2.png',fit: BoxFit.cover,),
      ],
    );
  }

  Widget _feeding() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            currentChallenge==null? FeedingChallengeContainer(
              contentText: 'Empecemos el habito de tomar agua',
              imagePath: 'assets/images/water-glass.png',
              inputFunction: () {
                Navigator.pushNamed(context, Routes.feeding_challenges);
              },
            ): ActualChallengeContainer(
              contentText: 'Que bueno verte de nuevo, completa el reto de hoy!',
              percent: currentChallenge.percent(),
              inputFunction: () {
                Navigator.pushNamed(context, Routes.feeding_challenges);
              },
            ),
            SizedBox(
              height: 10,
            ),
            FeedingChallengeContainer(
              contentText: 'Empecemos el hábito de comer fruta',
              imagePath: 'assets/images/fruit.png',
              inputFunction: () {},
            ),
            SizedBox(
              height: 10,
            ),
            FeedingChallengeContainer(
              contentText: 'Empecemos el hábito de comer verduras',
              imagePath: 'assets/images/no-image.jpg',
              inputFunction: () {},
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_map/features/mind_map/cubit/map_cubit/map_cubit.dart';
import 'package:mind_map/features/mind_map/domain/entity/map_entity.dart';

class AllMindMapsScreen extends StatefulWidget {
  const AllMindMapsScreen({super.key});

  @override
  State<AllMindMapsScreen> createState() => _AllMindMapsScreenState();
}

class _AllMindMapsScreenState extends State<AllMindMapsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MapCubit>().fetchMaps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'MindMaps',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFAD3743),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFAD3743)),
      ),
      body: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          if (state is MapLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MapError) {
            return Center(child: Text(state.message));
          }
          if (state is! MapsLoaded) {
            return const SizedBox.shrink();
          }

          final maps = state.maps;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MindMap',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Используем LayoutBuilder для точного расчета ширины карточек
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // Ширина карточки: (общая ширина - отступ между ними) / 2
                      final cardWidth = (constraints.maxWidth - 16) / 2;

                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          // 1. Кнопка добавления
                          GestureDetector(
                            onTap: () {
                              // TODO: Переход на экран создания карты
                            },
                            child: Container(
                              width: cardWidth,
                              height: cardWidth * 0.95, // Сделали чуть ниже
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  size: 40,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),

                          // 2. Карты из БД
                          ...maps.map((map) {
                            return _MapCard(map: map, cardWidth: cardWidth);
                          }),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MapCard extends StatelessWidget {
  final MapEntity map;
  final double cardWidth;

  const _MapCard({required this.map, required this.cardWidth});

  @override
  Widget build(BuildContext context) {
    // TODO: Когда сделаешь парсинг цвета, замени Colors.red
    // final color = map.sphere.color;

    return Container(
      width: cardWidth,
      height: cardWidth * 0.95, // Пропорции карточки
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.red, // Пока красная рамка
          width: 1.5,
        ),
        color: Colors.white,
      ),
      clipBehavior:
          Clip.hardEdge, // Чтобы внутренние элементы не вылезали за скругления
      child: Column(
        children: [
          // ВЕРХНЯЯ ЧАСТЬ (Холст)
          Expanded(
            child: Stack(
              children: [
                // Заглушка вместо холста (черный фон)
                Positioned.fill(
                  child: Container(
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        'Canvas preview',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                // Кнопка редактирования (карандаш)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.edit_outlined,
                    size: 18,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),

          // НИЖНЯЯ ЧАСТЬ (Информация)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.map_outlined, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        map.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Edited 3 months ago', // TODO: Заменить на реальную дату
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

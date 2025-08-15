import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
// 移除未使用的导入语句

import '../utils/utils.dart';

class EncryptPage extends StatefulWidget {
  @override
  State<EncryptPage> createState() => _EncryptPageState();
}

class _EncryptPageState extends State<EncryptPage> {
  final TextEditingController _controller = TextEditingController();
  final _keyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '输入待加密内容',
              ),
            ),
          ),
          Column(
            children: [
              TextField(
                controller: _keyController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '秘钥',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _encrypt(_controller.text),
                    child: Text('加密'),
                  ),
                  ElevatedButton(
                    onPressed: () => _pasteContent(),
                    child: Text('粘贴'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _encrypt(String text) async {
    final keyString = _keyController.text;
    try {
      final encrypted = AESUtil.encrypt(text, keyString);

      await Clipboard.setData(ClipboardData(text: encrypted));

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('加密成功, 已复制到剪贴板')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('加密失败: $e')));
    }
  }

  // 在State类中添加新方法
  void _pasteContent() async {
    try {
      final clipboardData = await Clipboard.getData('text/plain');
      if (clipboardData != null && clipboardData.text!.isNotEmpty) {
        setState(() {
          _controller.text = clipboardData.text!;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('剪贴板内容不可用')));
    }
  }

  // 执行组件销毁前的清理工作
  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }
}

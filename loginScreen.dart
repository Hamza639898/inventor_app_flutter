),
        ),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Text(
          'Or continue with',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: Icons.g_mobiledata,
              color: Colors.red.shade600,
            ),
            const SizedBox(width: 20),
            _buildSocialButton(
              icon: Icons.facebook,
              color: Colors.blue.shade600,
            ),
            const SizedBox(width: 20),
            _buildSocialButton(
              icon: Icons.apple,
              color: Colors.black,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({required IconData icon, required Color color}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: () {},
     ),
);
}
}

_:
let
  codexModelIds = {
    max = "gpt-5.1-codex-max";
    mini = "gpt-5.1-codex-mini";
  };
in
{
  programs.codex = {
    enable = true;
    settings = {
      approval_policy = "untrusted";
      check_for_update_on_startup = false;
      features = {
        apply_patch_freeform = false;
        enable_experimental_windows_sandbox = false;
        ghost_commit = false;
        rmcp_client = false;
        skills = false;
        tui2 = false;
        unified_exec = false;
        view_image_tool = false;
        web_search_request = true;
      };
      file_opener = "none";
      forced_login_method = "chatgpt";
      hide_agent_reasoning = false;
      model = codexModelIds.mini;
      model_context_window = 400000;
      model_provider = "openai";
      model_reasoning_effort = "high";
      model_reasoning_summary = "detailed";
      model_verbosity = "high";
      review_model = codexModelIds.max;
      sandbox_mode = "read-only";
      show_raw_agent_reasoning = false;
      tool_output_token_limit = 5000;
      tui = {
        animations = true;
        notifications = true;
      };
    };
  };
}

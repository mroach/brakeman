# Output detected by GitHub Actions to display as code links
# https://docs.github.com/en/actions/reference/workflow-commands-for-github-actions
class Brakeman::Report::Github < Brakeman::Report::Base
  def generate_report
    all_warnings.map { |warning| generate_output_line(warning) }.join("\n")
  end

  private

  def generate_output_line(warning)
    attrs = { file: warning.file.relative }
    attrs[:line] = warning.line if warning.line

    formatted_attrs = attrs.map { |k, v| "#{k}=#{v}" }.join(',')

    "::#{severity_level_for(warning.confidence)} #{formatted_attrs}::#{warning.message}"
  end

  def severity_level_for(confidence)
    if confidence == 0
      "error"
    else
      "warning"
    end
  end
end
